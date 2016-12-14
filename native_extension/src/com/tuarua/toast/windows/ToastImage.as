/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast.windows {
import com.tuarua.toast.constants.ToastHintCrop;
import com.tuarua.toast.constants.ToastPlacement;
import com.tuarua.windows10;
import com.tuarua.windows8;

use namespace windows8;

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
    windows8 var id:int = 0;
    /**
     *
     */
    windows10 var placement:String = ToastPlacement.INLINE;
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
    windows10 var hintCrop:String = ToastHintCrop.NONE;

    public function ToastImage(src:String = null, placement:String = "inline", alt:String = null,
                               addImageQuery:Boolean = false, hintCrop:String = "none",id:int = 0) {
        this.src = src;
        this.alt = alt;
        this.addImageQuery = addImageQuery;
        use namespace windows10;
        hintCrop = hintCrop;
        placement = placement;
        use namespace windows8;
        id = id;
    }
}
}