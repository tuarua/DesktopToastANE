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

public class SwiftController: NSObject {
    public static var TAG = "DesktopToastANE"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    func getNamespace(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        if #available(OSX 10.12.1, *) {
            return "osx".toFREObject()
        }
        return nil
    }
    
    func show(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 0,
            let toast: [String: AnyObject] = Dictionary(argv[0])
            else {
                return FreArgError().getError()
        }

        let notification = NSUserNotification()
        
        if let title = toast["title"] {
            notification.title = title as? String
        }
        
        if let subtitle = toast["subtitle"] {
            notification.subtitle = subtitle as? String
        }
        
        if let informativeText = toast["informativeText"] {
            notification.informativeText = informativeText as? String
        }
        
        if let contentImage = toast["contentImage"] as? String {
            let image: NSImage? = NSImage(byReferencingFile: contentImage)
            notification.contentImage = image
        }
        
        if let identifier = toast["identifier"] {
            notification.identifier = identifier as? String
        }
        
        if let responsePlaceholder = toast["responsePlaceholder"] {
            notification.responsePlaceholder = responsePlaceholder as? String
        }
        
        if let hasActionButton = toast["hasActionButton"] as? Bool {
            notification.hasActionButton = hasActionButton
        }
        
        if let hasReplyButton = toast["hasReplyButton"] as? Bool {
            notification.hasReplyButton = hasReplyButton
        }
        
        if let actionButtonTitle = toast["actionButtonTitle"] {
            notification.actionButtonTitle = (actionButtonTitle as? String)!
        }
        
        if let otherButtonTitle = toast["otherButtonTitle"] {
            notification.otherButtonTitle = (otherButtonTitle as? String)!
        }
        
        if let playSound: Bool = toast["playSound"] as? Bool {
            if playSound {
                notification.soundName = NSUserNotificationDefaultSoundName
            }
        }
        
        if let userInfo = toast["userInfo"] as? [String: Any] {
            notification.userInfo = userInfo
        }
        
        // Deliver the notification through the User Notification Center
        NSUserNotificationCenter.default.deliver(notification)
        return nil
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        NSUserNotificationCenter.default.delegate = self
        return nil
    }
    
}
