/**
 * Created by Eoin Landy on 01/12/2016.
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
        if(_selections == null)
            _selections = new Vector.<ToastInputSelection>
        _selections.push(selection);
    }

    public function get selections():Vector.<ToastInputSelection> {
        return _selections;
    }
}
}