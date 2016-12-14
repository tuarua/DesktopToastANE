/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast.windows {
import com.tuarua.windows10;
import com.tuarua.windows8;

use namespace windows8;

public class ToastText {
    /**
     *
     */
    public var language:String;
    /**
     *
     */
    public var content:String;
    /**
     *
     */
    windows8 var id:int = 0;
    /**
     *
     */
    windows10 var hintMaxLines:int = 0;

    public function ToastText(content:String = null, language:String = null, hintMaxLines:int = 0, id:int = 0) {
        this.content = content;
        this.language = language;
        use namespace windows10;
        hintMaxLines = hintMaxLines;
        use namespace windows8;
        id = id;
    }
}
}
