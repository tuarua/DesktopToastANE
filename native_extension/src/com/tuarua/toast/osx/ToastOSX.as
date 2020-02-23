/*
 *  Copyright 2017 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.tuarua.toast.osx {

public class ToastOSX {
    /** Specifies the title of the notification. */
    public var title:String;
    /** Specifies the subtitle of the notification. */
    public var subtitle:String;
    /** The body text of the notification. */
    public var informativeText:String;
    /** Image shown in the content of the notification. */
    public var contentImage:String;
    /** Identifier for a notification. */
    public var identifier:String;
    /** Optional placeholder string for inline reply field. */
    public var responsePlaceholder:String;
    /** A Boolean value that specifies whether the notification displays an action button. */
    public var hasActionButton:Boolean = false;
    /** A Boolean value that specifies whether the notification displays a reply button. */
    public var hasReplyButton:Boolean = false;
    /** Specifies the title of the action button displayed in the notification. */
    public var actionButtonTitle:String;
    /** Specifies a custom title for the close button in an alert-style notification. */
    public var otherButtonTitle:String;
    /** A Boolean value that specifies whether to play a sound when the notification is delivered.*/
    public var playSound:Boolean = true;
    /** Application-specific user info that can be attached to the notification. */
    public var userInfo:UserInfo;

    public function ToastOSX() {
        super();
    }


}
}

