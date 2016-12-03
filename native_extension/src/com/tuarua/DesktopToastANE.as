package com.tuarua {
import com.tuarua.toast.Toast;
import com.tuarua.toast.ToastAction;
import com.tuarua.toast.ToastEvent;
import com.tuarua.toast.ToastImage;
import com.tuarua.toast.ToastInput;
import com.tuarua.toast.ToastText;
import com.tuarua.toast.constants.ToastInputSelection;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;

public class DesktopToastANE extends EventDispatcher {
    private static const name:String = "DesktopToastANE";
    private var extensionContext:ExtensionContext;
    private var _appId:String;
    private var _xml:XML;
    private var _xmlAsString:String;
    private var isInited:Boolean = false;
    private var _isSupported:Boolean = false;

    public function DesktopToastANE() {
        initiate();
    }
	/**
	 * 
	 * @param appId 
	 * @param appName
	 * 
	 */
    public function init(appId:String, appName:String):void {
        if(_isSupported)
            extensionContext.call("init", appId, appName);
    }

    protected function initiate():void {
        isInited = true;
        _isSupported = (Capabilities.os.toLowerCase() == "windows 10");

        if(_isSupported){
            trace("We are on Windows 10 so supported");
            trace("["+name+"] Initalizing ANE...");
            try {
                extensionContext = ExtensionContext.createExtensionContext("com.tuarua.DesktopToastANE", null);
                extensionContext.addEventListener(StatusEvent.STATUS, gotEvent);
            } catch (e:Error) {
                trace("["+name+"] ANE Not loaded properly.  Future calls will fail.");
            }
        }else{
            trace("["+name+"] Can't initialize. Only Windows 8 and Windows 10 are supported");
        }

    }

    private function gotEvent(event:StatusEvent):void {
        var pObj:Object;
        switch (event.level) {
            case "TRACE":
                trace(event.code);
                break;
            case "INFO":
                trace("INFO:", event.code);
                break;
            case ToastEvent.TOAST_CLICKED:
                pObj = JSON.parse(event.code);
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_CLICKED,pObj));
                break;
            case ToastEvent.TOAST_DISMISSED:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_DISMISSED,pObj));
                break;
            case ToastEvent.TOAST_HIDDEN:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_HIDDEN,pObj));
            case ToastEvent.TOAST_TIMED_OUT:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_TIMED_OUT,pObj));
                break;
            case ToastEvent.TOAST_NOT_ACTIVATED:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_NOT_ACTIVATED,pObj));
                break;
            case ToastEvent.TOAST_ERROR:
                dispatchEvent(new ToastEvent(ToastEvent.TOAST_ERROR,pObj));
        }
    }
	/**
	 * 
	 * @param xml
	 * 
	 */
    public function createFromXML(xml:XML):void {
        _xmlAsString = xml.toString();
    }
	/**
	 * 
	 * @param toast
	 * 
	 */
    public function createFromToast(toast:Toast):void {
        var toastNode:XML = <toast/>;
        var visualNode:XML = <visual/>;
        var bindingNode:XML = <binding/>;
        var actionsNode:XML = <actions/>;
        var audioNode:XML = <audio/>;
        var inputNode:XML = <input/>;

        if (toast.launch)
            toastNode.@launch = toast.launch;
        toastNode.@duration = toast.duration;
        toastNode.@activationType = toast.activationType;
        toastNode.@scenario = toast.scenario;

        if (toast.visual.language)
            visualNode.@lang = toast.visual.language;
        visualNode.@baseUri = toast.visual.baseUri;
        visualNode.@addImageQuery = toast.visual.addImageQuery;

        bindingNode.@template = toast.binding.template;
        if (toast.binding.language)
            bindingNode.@lang = toast.binding.language;
        bindingNode.@baseUri = toast.binding.baseUri;
        bindingNode.@addImageQuery = toast.binding.addImageQuery;


        for each (var t:ToastText in toast.texts) {
            var textNode:XML = <text/>;
            textNode = textNode.appendChild(t.content);
            if (t.language)
                textNode.@lang = t.language;
            if (t.hintMaxLines > 0)
                textNode.@["hint-maxLines"] = t.hintMaxLines;
            bindingNode = bindingNode.appendChild(textNode);
        }

        for each (var i:ToastImage in toast.images) {
            var imageNode:XML = <image/>;
            imageNode.@src = i.src;
            imageNode.@placement = i.placement;
            if (i.alt)
                imageNode.@alt = i.alt;
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
                if (toast.input.title)
                    inputNode.@title = toast.input.title;
                inputNode.@placeHolderContent = toast.input.placeHolderContent;
                if (toast.input.defaultInput)
                    inputNode.@defaultInput = toast.input.defaultInput;

                for each (var sel:ToastInputSelection in toast.input.selections) {
                    var selectionNode:XML = <selection/>;
                    selectionNode.@id = sel.id;
                    selectionNode.@content = sel.content;
                    inputNode.appendChild(selectionNode);
                }
                actionsNode.appendChild(inputNode);
            }
            for each (var a:ToastAction in toast.actions) {
                var actionNode:XML = <action />;
                actionNode.@activationType = a.activationType;
                actionNode.@content = a.content;
                if (a.arguments)
                    actionNode.@arguments = a.arguments;
                if (a.hintInputId)
                    actionNode.@["hint-inputId"] = a.hintInputId;
                if (a.imageUri)
                    actionNode.@imageUri = a.imageUri;

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
	/**
	 * 
	 * 
	 */
    public function show():void {
        if (isInited)
            extensionContext.call("show", _xmlAsString);
        else
            trace("You forgot to call .init() first");
    }

    public function dispose():void {
        if (!extensionContext) {
            trace("["+name+"] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("["+name+"] Unloading ANE...");
        extensionContext.removeEventListener(StatusEvent.STATUS, gotEvent);
        extensionContext.dispose();
        extensionContext = null;
    }
	/**
	 * 
	 * @return 
	 * 
	 */
    public function get isSupported():Boolean {
        return _isSupported;
    }
}
}