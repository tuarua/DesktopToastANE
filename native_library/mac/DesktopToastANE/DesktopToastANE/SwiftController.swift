/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/

import Foundation
import Cocoa
import FreSwift

public class SwiftController: NSObject, FreSwiftMainController, NSUserNotificationCenterDelegate {
    public var TAG: String? = "DesktopToastANE"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    // Must have this function. It exposes the methods to our entry ObjC.
    @objc public func getFunctions(prefix: String) -> Array<String> {
        
        functionsToSet["\(prefix)init"] = initController
        functionsToSet["\(prefix)show"] = show
        functionsToSet["\(prefix)getNamespace"] = getNamespace
        
        var arr: Array<String> = []
        for key in functionsToSet.keys {
            arr.append(key)
        }
        return arr
    }
    
    public func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        var jsonString = "{\"arguments\" :\"\"}"
        if let userInfo = notification.userInfo {
            var dict:Dictionary = Dictionary<String, AnyObject>()
            if let arguments = userInfo["arguments"] {
                dict.updateValue(arguments as AnyObject, forKey: "arguments")
                var array:Array<Dictionary<String,AnyObject>> = Array()
                if let response = notification.response {
                    var dataDict:Dictionary<String,AnyObject> = Dictionary()
                    dataDict.updateValue("response" as AnyObject , forKey: "key")
                    dataDict.updateValue(response.string as AnyObject , forKey: "value")
                    array.append(dataDict)
                }
                
                if notification.identifier != nil {
                    var dataDict:Dictionary<String,AnyObject> = Dictionary()
                    dataDict.updateValue("id" as AnyObject , forKey: "key")
                    dataDict.updateValue(notification.identifier as AnyObject , forKey: "value")
                    array.append(dataDict)
                }

                dict.updateValue(array as AnyObject, forKey: "data")
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                
             } catch {
                trace("Error reading reponse",error.localizedDescription)
            }
  
        }
        do {
            try context.dispatchStatusEventAsync(code: jsonString, level: "Toast.Clicked")
        } catch {
        }
        
    }
    
    public func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    func getNamespace(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        if #available(OSX 10.12.1, *) {
            return "osx".toFREObject()
        }
        return nil
    }
    
    func show(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let toast:Dictionary<String, AnyObject> = Dictionary.init(argv[0])
            else {
                return ArgCountError(message: "show").getError(#file, #line, #column)
        }

        let notification = NSUserNotification.init()
        
        if let title = toast["title"] {
            notification.title = title as? String
        }
        
        if let subtitle = toast["subtitle"] {
            notification.subtitle = subtitle as? String
        }
        
        if let informativeText = toast["informativeText"] {
            notification.informativeText = informativeText as? String
        }
        
        if let contentImage = toast["contentImage"] {
            let image:NSImage? = NSImage(byReferencingFile: contentImage as! String)
            notification.contentImage = image
        }
        
        if let identifier = toast["identifier"] {
            notification.identifier = identifier as? String
        }
        
        if let responsePlaceholder = toast["responsePlaceholder"] {
            notification.responsePlaceholder = responsePlaceholder as? String
        }
        
        if let hasActionButton = toast["hasActionButton"] {
            notification.hasActionButton = hasActionButton as! Bool
        }
        
        if let hasReplyButton = toast["hasReplyButton"] {
            notification.hasReplyButton = hasReplyButton as! Bool
        }
        
        if let actionButtonTitle = toast["actionButtonTitle"] {
            notification.actionButtonTitle = (actionButtonTitle as? String)!
        }
        
        if let otherButtonTitle = toast["otherButtonTitle"] {
            notification.otherButtonTitle = (otherButtonTitle as? String)!
        }
        
        if let playSound:Bool = toast["playSound"] as! Bool? {
            if playSound {
                notification.soundName = NSUserNotificationDefaultSoundName
            }
        }
        
        if let userInfo = toast["userInfo"] {
            notification.userInfo = userInfo as? [String : Any] //
        }
        
        // Deliver the notification through the User Notification Center
        NSUserNotificationCenter.default.deliver(notification)
        return nil
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        NSUserNotificationCenter.default.delegate = self
        return nil
    }
    
    // Must have this function. It exposes the methods to our entry ObjC.
    @objc public func callSwiftFunction(name: String, ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        if let fm = functionsToSet[name] {
            return fm(ctx, argc, argv)
        }
        return nil
    }
    
    @objc public func setFREContext(ctx: FREContext) {
        self.context = FreContextSwift.init(freContext: ctx)
    }
    
    @objc public func onLoad() {
        
    }


}







