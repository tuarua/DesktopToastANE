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
public class ToastAudio {
    public var src:String;
    public var loop:Boolean = false;
    public var silent:Boolean = false;

    /**
     *
     * @param src
     * @param loop
     * @param silent
     *
     */
    public function ToastAudio(src:String = null, loop:Boolean = false, silent:Boolean = false) {
        this.src = src;
        this.loop = loop;
        this.silent = silent;
    }
}
}