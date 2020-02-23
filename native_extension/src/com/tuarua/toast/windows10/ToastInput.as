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
package com.tuarua.toast.windows10 {
import com.tuarua.toast.constants.ToastInputSelection;
import com.tuarua.toast.constants.ToastInputType;

public class ToastInput {
    public var id:String;
    public var type:String = ToastInputType.TEXT;
    public var title:String;
    public var placeHolderContent:String;
    public var defaultInput:String;
    private var _selections:Vector.<ToastInputSelection>;

    public function ToastInput() {
    }

    public function addSelection(selection:ToastInputSelection):void {
        if (_selections == null) _selections = new Vector.<ToastInputSelection>
        _selections.push(selection);
    }

    public function get selections():Vector.<ToastInputSelection> {
        return _selections;
    }
}
}