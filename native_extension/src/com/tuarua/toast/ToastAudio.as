/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast {
/**
 * 
 * @author Eoin Landy
 * 
 */	
public class ToastAudio {
	/**
	 * 
	 */	
    public var src:String;
	/**
	 * 
	 */	
    public var loop:Boolean = false;
	/**
	 * 
	 */	
    public var silent:Boolean = false;
	/**
	 * 
	 * @param src
	 * @param loop
	 * @param silent
	 * 
	 */	
    public function ToastAudio(src:String= null, loop:Boolean = false, silent:Boolean = false) {
        this.src = src;
        this.loop = loop;
        this.silent = silent;
    }
}
}