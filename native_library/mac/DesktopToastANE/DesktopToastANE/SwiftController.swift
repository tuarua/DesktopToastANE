/*@copyright The code is licensed under the[MIT
 License](http://opensource.org/licenses/MIT):
 
 Copyright © 2017 -  Tua Rua Ltd.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files(the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions :
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.*/

import Foundation
import Cocoa
import FreSwift

@objc class SwiftController: FreSwiftController , NSUserNotificationCenterDelegate {
    
    // Must have this function. It exposes the methods to our entry ObjC.
    func getFunctions() -> Array<String> {
        functionsToSet["init"] = initController
        functionsToSet["show"] = show
        functionsToSet["getNamespace"] = getNamespace
        
        var arr: Array<String> = []
        for key in functionsToSet.keys {
            arr.append(key)
        }
        return arr
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        var jsonString = "{\"arguments\" :\"\"}"
        if let userInfo = notification.userInfo {
            var dict:Dictionary = Dictionary<String, AnyObject>()
            if let arguments = userInfo["arguments"] {
                trace("let arguments")
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
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    func getNamespace(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        var ret:FREObject? = nil
        if #available(OSX 10.12.1, *) {
            do {
                ret = try FreObjectSwift(string: "osx").rawValue
            } catch {
            }
        }
        return ret
    }
    
    func show(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let inFRE0 = argv[0],
            let toast = FreObjectSwift.init(freObject: inFRE0).value as? Dictionary<String, AnyObject>
            else {
                traceError(message: "show - incorrect arguments", line: #line, column: #column, file: #file, freError: nil)
                return nil
        }
        
        let toast22 = FreObjectSwift.init(freObject: inFRE0)
        
        trace("toast.debugDescription",toast.debugDescription)
        
        trace("toast.debugDescription2",toast22.value)
        
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
       
        //trace(toast.debugDescription)
        //trace("notification.userInfo:",notification.userInfo)
        //trace("_____________");
        
        // Deliver the notification through the User Notification Center
        NSUserNotificationCenter.default.deliver(notification)
        return nil
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        NSUserNotificationCenter.default.delegate = self
        return nil
    }
    
    

    func setFREContext(ctx: FREContext) {
        context = FreContextSwift.init(freContext: ctx)
    }


}







