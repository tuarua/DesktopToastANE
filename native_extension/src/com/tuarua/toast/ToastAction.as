/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast {
import com.tuarua.toast.constants.ToastActivationType;

public class ToastAction {
	/**
	 * <p></p> 
	 */
    public var activationType:String = ToastActivationType.FOREGROUND;
	/**
	 * 
	 */	
    public var content:String;
	/**
	 * 
	 */	
    public var arguments:String;
	/**
	 * 
	 */	
    public var imageUri:String;
	/**
	 * 
	 */	
    public var hintInputId:String;
	/**
	 * 
	 * 
	 */	
    public function ToastAction() {
    }
}
}