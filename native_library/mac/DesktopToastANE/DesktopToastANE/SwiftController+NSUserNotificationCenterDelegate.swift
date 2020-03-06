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

extension SwiftController: NSUserNotificationCenterDelegate {
      public func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
          var jsonString = "{\"arguments\" :\"\"}"
          if let userInfo = notification.userInfo {
              var dict: [String: AnyObject] = Dictionary()
              if let arguments = userInfo["arguments"] {
                  dict.updateValue(arguments as AnyObject, forKey: "arguments")
                  var array: [[String: AnyObject]] = Array()
                  if let response = notification.response {
                      var dataDict: [String: AnyObject] = Dictionary()
                      dataDict.updateValue("response" as AnyObject, forKey: "key")
                      dataDict.updateValue(response.string as AnyObject, forKey: "value")
                      array.append(dataDict)
                  }
                  
                  if notification.identifier != nil {
                      var dataDict: [String: AnyObject] = Dictionary()
                      dataDict.updateValue("id" as AnyObject, forKey: "key")
                      dataDict.updateValue(notification.identifier as AnyObject, forKey: "value")
                      array.append(dataDict)
                  }

                  dict.updateValue(array as AnyObject, forKey: "data")
              }

              do {
                  let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                  jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                  
               } catch {
                  trace("Error reading reponse", error.localizedDescription)
              }
    
          }
          dispatchEvent(name: "Toast.Clicked", value: jsonString)
      }
      
      public func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
          return true
      }
}
