/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast {
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
    public var hintMaxLines:int = 0;
	/**
	 * 
	 * @param content
	 * @param language
	 * @param hintMaxLines
	 * 
	 */	
    public function ToastText(content:String = null, language:String = null, hintMaxLines:int = 0) {
        this.content = content;
        this.language = language;
        this.hintMaxLines = hintMaxLines;
    }
}
}
