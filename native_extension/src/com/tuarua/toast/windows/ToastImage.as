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
package com.tuarua.toast.windows {
import com.tuarua.toast.constants.ToastHintCrop;
import com.tuarua.toast.constants.ToastPlacement;
import com.tuarua.windows10;
import com.tuarua.windows8;

use namespace windows8;
public class ToastImage {
    public var src:String;
    windows8 var id:int = 0;
    windows10 var placement:String = ToastPlacement.INLINE;
    public var alt:String;
    public var addImageQuery:Boolean = false;
    windows10 var hintCrop:String = ToastHintCrop.NONE;

    public function ToastImage(src:String = null, placement:String = "inline", alt:String = null, addImageQuery:Boolean = false, hintCrop:String = "none", id:int = 0) {
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