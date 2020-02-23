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

package com.tuarua {
import com.tuarua.toast.ToastEvent;
import com.tuarua.toast.constants.ToastInputSelection;
import com.tuarua.toast.osx.ToastOSX;
import com.tuarua.toast.windows.ToastImage;
import com.tuarua.toast.windows.ToastText;
import com.tuarua.toast.windows10.Toast10;
import com.tuarua.toast.windows10.ToastAction;
import com.tuarua.toast.windows8.Toast8;
import com.tuarua.toast.windows8.ToastCommand;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;

public class DesktopToastANE extends EventDispatcher {
    private static const name:String = "DesktopToastANE";
    private var extensionContext:ExtensionContext;
    private var _xmlAsString:String;
    private var isInited:Boolean = false;
    private var _isSupported:Boolean = false;
    private var _namespace:String;
    osx var _toast:ToastOSX;

    public function DesktopToastANE() {
        initiate();
    }

    osx function init():void {
        trace("OSX namespace");
        if (_isSupported) extensionContext.call("init");
    }

    windows10 function init(appId:String, appName:String):void {
        trace("Windows 10 namespace");
        if (_isSupported) extensionContext.call("init", appId, appName);
    }

    windows8 function init(appId:String, appName:String):void {
        trace("Windows 8 namespace");
        if (_isSupported) extensionContext.call("init", appId, appName);
    }

    protected function initiate():void {
        isInited = true;

        if (Capabilities.os.toLowerCase() == "windows 10") {
            _isSupported = true;
        } else if (Capabilities.os.toLowerCase().indexOf("mac os") > -1) {
            _isSupported = true;
        } else if (Capabilities.os.toLowerCase() == "windows 8") {
            _isSupported = true;
        }

        if (_isSupported) {
            trace("[" + name + "] Initalizing ANE...");
            try {
                extensionContext = ExtensionContext.createExtensionContext("com.tuarua.DesktopToastANE", null);
                extensionContext.addEventListener(StatusEvent.STATUS, gotEvent);
                _namespace = extensionContext.call("getNamespace") as String;
            } catch (e:Error) {
                _isSupported = false;
                trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
                trace(e.getStackTrace());
                trace(e.message);
            }
        } else {
            trace("[" + name + "] Can't initialize. Windows 8.1, 10 and OSX are supported");
        }

    }

    private function gotEvent(event:StatusEvent):void {
        var pObj:Object;
        switch (event.level) {
            case "TRACE":
                trace("[" + name + "]", event.code);
                break;
            case ToastEvent.TOAST_CLICKED:
                try {
                    pObj = JSON.parse(event.code);
                } catch (e:Error) {
                    trace(e.message);
                }
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_CLICKED, pObj));
                break;
            case ToastEvent.TOAST_DISMISSED:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_DISMISSED, pObj));
                break;
            case ToastEvent.TOAST_HIDDEN:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_HIDDEN, pObj));
                break;
            case ToastEvent.TOAST_TIMED_OUT:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_TIMED_OUT, pObj));
                break;
            case ToastEvent.TOAST_NOT_ACTIVATED:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_NOT_ACTIVATED, pObj));
                break;
            case ToastEvent.TOAST_ERROR:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_ERROR, pObj));
        }
    }

    osx function createFromToast(toast:ToastOSX):void {
        use namespace osx;

        _toast = toast;
    }

    windows10 function createFromXML(xml:XML):void {
        _xmlAsString = xml.toString();
    }

    windows8 function createFromXML(xml:XML):void {
        _xmlAsString = xml.toString();
    }

    windows8 function createFromToast(toast:Toast8):void {
        use namespace windows8;

        var toastNode:XML = <toast/>;
        var visualNode:XML = <visual/>;
        var bindingNode:XML = <binding/>;
        var commandsNode:XML = <commands/>;
        var audioNode:XML = <audio/>;

        if (toast.visual.language) visualNode.@lang = toast.visual.language;
        visualNode.@baseUri = toast.visual.baseUri;
        visualNode.@addImageQuery = toast.visual.addImageQuery;

        bindingNode.@template = toast.binding.template;
        if (toast.binding.language) bindingNode.@lang = toast.binding.language;
        bindingNode.@baseUri = toast.binding.baseUri;
        bindingNode.@addImageQuery = toast.binding.addImageQuery;

        if (toast.audio) {
            audioNode.@src = toast.audio.src;
            audioNode.@loop = toast.audio.loop;
            audioNode.@silent = toast.audio.silent;
            toastNode = toastNode.appendChild(audioNode);
        }

        var numLines:int = 0;

        for each (var t:ToastText in toast.texts) {
            var textNode:XML = <text/>;
            textNode = textNode.appendChild(t.content);
            if (t.language) textNode.@lang = t.language;
            if (t.id > 0) textNode.@id = t.id;
            bindingNode = bindingNode.appendChild(textNode);
            numLines++;
            if (numLines > 4) break;
        }

        var hasImage:Boolean;
        for each (var i:ToastImage in toast.images) {
            var imageNode:XML = <image/>;
            imageNode.@src = i.src;
            imageNode.@id = i.id;
            if (i.alt) imageNode.@alt = i.alt;
            imageNode.@addImageQuery = i.addImageQuery;
            bindingNode = bindingNode.appendChild(imageNode);
            hasImage = true;
        }

        if (hasImage) bindingNode.@template = "ToastImageAndText0" + numLines.toString(); else bindingNode.@template = "ToastText0" + numLines.toString();

        visualNode = visualNode.appendChild(bindingNode);
        toastNode = toastNode.appendChild(visualNode);

        if (toast.commands && toast.commands.scenario) {
            commandsNode.@scenario = toast.commands.scenario;
            for each (var c:ToastCommand in toast.commands.commands) {
                var commandNode:XML = <command/>;
                if (c.arguments) commandNode.@arguments = c.arguments;
                if (c.id) commandNode.@id = c.id;
                commandsNode = commandsNode.appendChild(commandNode);
            }
            toastNode = toastNode.appendChild(commandsNode);
        }

        _xmlAsString = toastNode.toString();
    }

    windows10 function createFromToast(toast:Toast10):void {
        use namespace windows10

        var toastNode:XML = <toast/>;
        var visualNode:XML = <visual/>;
        var bindingNode:XML = <binding/>;
        var actionsNode:XML = <actions/>;
        var audioNode:XML = <audio/>;
        var inputNode:XML = <input/>;

        if (toast.launch) toastNode.@launch = toast.launch;
        toastNode.@duration = toast.duration;
        toastNode.@activationType = toast.activationType;
        toastNode.@scenario = toast.scenario;

        if (toast.visual.language) visualNode.@lang = toast.visual.language;
        visualNode.@baseUri = toast.visual.baseUri;
        visualNode.@addImageQuery = toast.visual.addImageQuery;

        bindingNode.@template = toast.binding.template;
        if (toast.binding.language) bindingNode.@lang = toast.binding.language;
        bindingNode.@baseUri = toast.binding.baseUri;
        bindingNode.@addImageQuery = toast.binding.addImageQuery;

        for each (var t:ToastText in toast.texts) {
            var textNode:XML = <text/>;
            textNode = textNode.appendChild(t.content);
            if (t.language) textNode.@lang = t.language;
            if (t.hintMaxLines > 0) textNode.@["hint-maxLines"] = t.hintMaxLines;
            bindingNode = bindingNode.appendChild(textNode);
        }

        for each (var i:ToastImage in toast.images) {
            var imageNode:XML = <image/>;
            imageNode.@src = i.src;
            imageNode.@placement = i.placement;
            if (i.alt) imageNode.@alt = i.alt;
            imageNode.@addImageQuery = i.addImageQuery;
            imageNode.@["hint-crop"] = i.hintCrop;
            bindingNode = bindingNode.appendChild(imageNode);
        }

        visualNode = visualNode.appendChild(bindingNode);
        toastNode = toastNode.appendChild(visualNode);

        if (toast.actions) {
            if (toast.input) {
                inputNode.@id = toast.input.id;
                inputNode.@type = toast.input.type;
                if (toast.input.title) inputNode.@title = toast.input.title;
                inputNode.@placeHolderContent = toast.input.placeHolderContent;
                if (toast.input.defaultInput) inputNode.@defaultInput = toast.input.defaultInput;

                for each (var sel:ToastInputSelection in toast.input.selections) {
                    var selectionNode:XML = <selection/>;
                    selectionNode.@id = sel.id;
                    selectionNode.@content = sel.content;
                    inputNode.appendChild(selectionNode);
                }
                actionsNode.appendChild(inputNode);
            }
            for each (var a:ToastAction in toast.actions) {
                var actionNode:XML = <action/>;
                actionNode.@activationType = a.activationType;
                actionNode.@content = a.content;
                if (a.arguments) actionNode.@arguments = a.arguments;
                if (a.hintInputId) actionNode.@["hint-inputId"] = a.hintInputId;
                if (a.imageUri) actionNode.@imageUri = a.imageUri;

                actionsNode = actionsNode.appendChild(actionNode);
            }
            toastNode = toastNode.appendChild(actionsNode);
        }

        if (toast.audio) {
            audioNode.@src = toast.audio.src;
            audioNode.@loop = toast.audio.loop;
            audioNode.@silent = toast.audio.silent;
            toastNode = toastNode.appendChild(audioNode);
        }

        _xmlAsString = toastNode.toString();

        /*

         <toast launch? duration? activationType? scenario? >
           <visual lang? baseUri? addImageQuery? >
             <binding template? lang? baseUri? addImageQuery? >
               <text lang? hint-maxLines? >content</text>
               <image src placement? alt? addImageQuery? hint-crop? />
               <group>
                 <subgroup hint-weight? hint-textStacking? >
                   <text />
                   <image />
                 </subgroup>
               </group>
             </binding>
           </visual>
           <audio src? loop? silent? />
         </toast>
         */

    }

    osx function show():void {
        use namespace osx;

        if (isInited) extensionContext.call("show", _toast); else trace("You forgot to call .init() first");
    }

    windows8 function show():void {
        if (isInited) extensionContext.call("show", _xmlAsString); else trace("You forgot to call .init() first");
    }

    windows10 function show():void {
        if (isInited) extensionContext.call("show", _xmlAsString); else trace("You forgot to call .init() first");
    }

    public function dispose():void {
        if (!extensionContext) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        extensionContext.removeEventListener(StatusEvent.STATUS, gotEvent);
        extensionContext.dispose();
        extensionContext = null;
    }

    public function get supportedNamespace():String {
        return _namespace;
    }
}
}