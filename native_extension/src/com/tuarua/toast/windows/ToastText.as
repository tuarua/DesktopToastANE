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
import com.tuarua.windows10;
import com.tuarua.windows8;

use namespace windows8;

public class ToastText {
    public var language:String;
    public var content:String;
    windows8 var id:int = 0;
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
