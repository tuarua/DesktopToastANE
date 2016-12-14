/**
 * Created by Eoin Landy on 14/12/2016.
 */
package com.tuarua.toast.windows8 {
public class ToastCommands {
    public var scenario:String = "alarm";
    private var _commands:Vector.<ToastCommand>;
    public function ToastCommands(scenario:String=null) {
        this.scenario = scenario;
    }

    public function addCommand(command:ToastCommand):void {
        if (_commands == null)
            _commands = new Vector.<ToastCommand>
        _commands.push(command);
    }
    /**
     *
     * @return
     *
     */
    public function get commands():Vector.<ToastCommand> {
        return _commands;
    }

}
}
