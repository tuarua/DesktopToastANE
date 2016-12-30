//
//  SwiftOSXANE.swift
//  SwiftOSXANE
//
//  Created by User on 04/12/2016.
//  Copyright © 2016 Tua Rua Ltd. All rights reserved.
//

import Cocoa
import Foundation

@objc class DesktopToastANE: NSObject, NSUserNotificationCenterDelegate {

    private var dllContext: FREContext!
    private let aneHelper = ANEHelper()

    private func trace(value:String) {
        FREDispatchStatusEventAsync(self.dllContext, value, "TRACE")
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        var jsonString = ""
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

                /*
                for i in 0..<2 {
                    var dataDict:Dictionary<String,AnyObject> = Dictionary()
                    dataDict.updateValue(i as AnyObject , forKey: "key")
                    dataDict.updateValue(i as AnyObject , forKey: "value")
                    array.append(dataDict)
                }
                */
                dict.updateValue(array as AnyObject, forKey: "data")
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                
             } catch {
                print(error.localizedDescription)
            }
        }
        
        FREDispatchStatusEventAsync(self.dllContext, jsonString, "Toast.Clicked")
        
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    
    
    func show(argv:NSPointerArray) {
        let inFRE:FREObject! = argv.pointer(at: 0)
        let toast:Dictionary<String, AnyObject> = aneHelper.getIdObjectFromFREObject(freObject: inFRE)
            as! Dictionary<String, AnyObject>
        
        Swift.debugPrint(toast)
        
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
            notification.userInfo = userInfo as? [String : Any]
        }
       
        
        // Deliver the notification through the User Notification Center
        NSUserNotificationCenter.default.deliver(notification)
        
    }
    
    func initNotification(argv:NSPointerArray) {
        trace(value: "init called")
        NSUserNotificationCenter.default.delegate = self
        trace(value: "delegate set")
    }
    

    func setFREContext(ctx: FREContext) {
        dllContext = ctx
        aneHelper.setFREContext(ctx:ctx)
    }


}







