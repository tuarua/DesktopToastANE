/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast.windows {
import com.tuarua.windows10;
import com.tuarua.windows8;

use namespace windows8;

public class ToastBinding {
    windows10 var template:String = "ToastGeneric";
    windows8 var template:String = "ToastImageAndText01";
    public var language:String;
    public var baseUri:String = "file:///";
    public var addImageQuery:Boolean = false;
    public function ToastBinding() {
    }
}
}
