/**
 * Created by Eoin Landy on 14/12/2016.
 */
package com.tuarua.toast.windows8 {
public class ToastCommand {
    public var id:String;
    public var arguments:String;
    public function ToastCommand(id:String=null,arguments:String=null) {
        this.id = id;
        this.arguments = arguments;
    }

}
}