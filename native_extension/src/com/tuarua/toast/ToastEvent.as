/**
 * Created by Eoin Landy on 01/12/2016.
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
