/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast.windows8 {
import com.tuarua.toast.constants.ToastDuration;
import com.tuarua.toast.windows.ToastAudio;
import com.tuarua.toast.windows.ToastImage;
import com.tuarua.toast.windows.ToastText;
import com.tuarua.toast.windows.ToastVisual;
import com.tuarua.toast.windows.ToastBinding;
import com.tuarua.windows8;

/**
 *
 * @author Eoin Landy
 *
 */
use namespace windows8;
public class Toast8 {
    public var duration:String = ToastDuration.SHORT;
    public var launch:String;
    public var binding:ToastBinding = new ToastBinding();
    public var visual:ToastVisual = new ToastVisual();
    private var _images:Vector.<ToastImage>;
    private var _texts:Vector.<ToastText>;
    private var _audio:ToastAudio;
    public var commands:ToastCommands;

    public function Toast8(launch:String = null, duration:String = "short") {
        this.launch = launch;
        this.duration = duration;
    }

    /**
     *
     * @param text
     *
     */
    public function addText(text:ToastText):void {
        if (_texts == null)
            _texts = new Vector.<ToastText>
        _texts.push(text);
    }

    /**
     *
     * @param image
     *
     */
    public function addImage(image:ToastImage):void {
        if (_images == null)
            _images = new Vector.<ToastImage>
        _images.push(image);
    }

    /**
     *
     * @param audio
     *
     */
    public function addAudio(audio:ToastAudio):void {
        this._audio = audio;
    }

    /**
     *
     * @return
     *
     */
    public function get texts():Vector.<ToastText> {
        return _texts;
    }

    /**
     *
     * @return
     *
     */
    public function get audio():ToastAudio {
        return _audio;
    }

    /**
     *
     * @return
     *
     */
    public function get images():Vector.<ToastImage> {
        return _images;
    }

}
}