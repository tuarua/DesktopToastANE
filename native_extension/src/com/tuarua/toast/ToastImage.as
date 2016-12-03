/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast {
import com.tuarua.toast.constants.ToastHintCrop;
import com.tuarua.toast.constants.ToastPlacement;
/**
 * 
 * @author Eoin Landy
 * 
 */
public class ToastImage {
	/**
	 * 
	 */	
    public var src:String;
	/**
	 * 
	 */	
    public var placement:String = ToastPlacement.INLINE;
	/**
	 * 
	 */	
    public var alt:String;
	/**
	 * 
	 */	
    public var addImageQuery:Boolean = false;
	/**
	 * 
	 */	
    public var hintCrop:String = ToastHintCrop.NONE;
	/**
	 * 
	 * @param src
	 * @param placement
	 * @param alt
	 * @param addImageQuery
	 * @param hintCrop
	 * 
	 */
    public function ToastImage(src:String = null, placement:String = "inline", alt:String = null,
                               addImageQuery:Boolean = false, hintCrop:String = "none") {
        this.src = src;
        this.placement = placement;
        this.alt = alt;
        this.addImageQuery = addImageQuery;
        this.hintCrop = hintCrop;
    }
}
}