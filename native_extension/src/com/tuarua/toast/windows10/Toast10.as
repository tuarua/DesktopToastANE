/**
 * Created by Eoin Landy on 30/11/2016.
 */
package com.tuarua.toast.windows10 {
import com.tuarua.toast.constants.ToastActivationType;
import com.tuarua.toast.constants.ToastDuration;
import com.tuarua.toast.constants.ToastScenario;
import com.tuarua.toast.windows.ToastAudio;
import com.tuarua.toast.windows.ToastBinding;
import com.tuarua.toast.windows.ToastImage;
import com.tuarua.toast.windows.ToastText;
import com.tuarua.toast.windows.ToastVisual;
import com.tuarua.windows10;

/**
 *
 * @author Eoin Landy
 *
 */

use namespace windows10;

public class Toast10 {
    public var duration:String = ToastDuration.SHORT;
    public var activationType:String = ToastActivationType.FOREGROUND;
    public var scenario:String = ToastScenario.DEFAULT;
    public var launch:String;
    public var visual:ToastVisual = new ToastVisual();
    public var binding:ToastBinding = new ToastBinding();
    private var _images:Vector.<ToastImage>;
    private var _texts:Vector.<ToastText>;
    private var _actions:Vector.<ToastAction>;
    private var _audio:ToastAudio;
    private var _input:ToastInput;


    /**
     *
     * @param launch
     * @param duration
     * @param activationType
     * @param scenario
     *
     */
    public function Toast10(launch:String = null, duration:String = "short",
                            activationType:String = "foreground", scenario:String = "default") {
        this.launch = launch;
        this.duration = duration;
        this.activationType = activationType;
        this.scenario = scenario;
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
     * @param action
     *
     */
    public function addAction(action:ToastAction):void {
        if (_actions == null)
            _actions = new Vector.<ToastAction>
        _actions.push(action);
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
     * @param input
     *
     */
    public function addInput(input:ToastInput):void {
        this._input = input;
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
    public function get actions():Vector.<ToastAction> {
        return _actions;
    }

    /**
     *
     * @return
     *
     */
    public function get images():Vector.<ToastImage> {
        return _images;
    }

    /**
     *
     * @return
     *
     */
    public function get input():ToastInput {
        return _input;
    }
}
}