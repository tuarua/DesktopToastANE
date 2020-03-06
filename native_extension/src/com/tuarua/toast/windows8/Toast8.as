/*
 *  Copyright 2017 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
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

    public function addText(text:ToastText):void {
        if (_texts == null) _texts = new Vector.<ToastText>;
        _texts.push(text);
    }

    public function addImage(image:ToastImage):void {
        if (_images == null) _images = new Vector.<ToastImage>;
        _images.push(image);
    }

    public function addAudio(audio:ToastAudio):void {
        this._audio = audio;
    }

    public function get texts():Vector.<ToastText> {
        return _texts;
    }

    public function get audio():ToastAudio {
        return _audio;
    }

    public function get images():Vector.<ToastImage> {
        return _images;
    }

}
}