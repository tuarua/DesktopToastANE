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
package com.tuarua.toast {
import flash.events.Event;

public class ToastEvent extends Event {
    public static const TOAST_ERROR:String = "Toast.Error";
    public static const TOAST_DISMISSED:String = "Toast.Dismissed";
    public static const TOAST_TIMED_OUT:String = "Toast.TimedOut";
    public static const TOAST_HIDDEN:String = "Toast.Hidden";
    public static const TOAST_CLICKED:String = "Toast.Clicked";
    public static const TOAST_NOT_ACTIVATED:String = "Toast.NotActivated";
    public var params:Object;
    public function ToastEvent(type:String, params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
        this.params = params;
    }
    public override function clone():Event {
        return new ToastEvent(type, this.params, bubbles, cancelable);
    }
    public override function toString():String {
        return formatToString("ToastEvent", "params", "type", "bubbles", "cancelable");
    }
}
}
