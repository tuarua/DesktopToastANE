/**
 * Created by User on 11/12/2016.
 */
package {
import com.tuarua.ANEObject;
import com.tuarua.DesktopToastANE;
import com.tuarua.osx;
import com.tuarua.toast.ToastEvent;
import com.tuarua.toast.osx.ToastOSX;

import flash.desktop.NativeApplication;
import flash.display.NativeWindow;
import flash.display.NativeWindowDisplayState;
import flash.events.Event;
import flash.filesystem.File;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.text.TextFormat;
import starling.utils.Align;

import utils.GUID;

import views.ScrollableContent;

public class StarlingRoot_OSX extends Sprite {
    private var dtANE:DesktopToastANE = new DesktopToastANE();
    private var image1:Image = new Image(Assets.getAtlas().getTexture("osx_reply"));
    private var image2:Image = new Image(Assets.getAtlas().getTexture("osx_hello"));
    private var list:ScrollableContent;
    private var holder:Sprite = new Sprite();
    private var callbackTxt:TextField;

    use namespace osx;

    public function StarlingRoot_OSX() {
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
    }

    public function start():void {
        NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, onExiting);


        dtANE.init();
        dtANE.addEventListener(ToastEvent.TOAST_CLICKED, onToastClicked);

        image1.addEventListener(TouchEvent.TOUCH, onImage1Touch);
        image1.useHandCursor = true;
        holder.addChild(image1);
        holder.addChild(createLbl("Notification with Reply button and response", 400, 0));


        image2.addEventListener(TouchEvent.TOUCH, onImage2Touch);
        image2.useHandCursor = true;
        image2.y = image1.height + 20;
        holder.addChild(image2);

        holder.addChild(createLbl("Notification with title, subtitle, informative text and image", 400, image2.y));


        list = new ScrollableContent(840, 600, holder);
        list.x = 50;
        list.y = 150;
        list.fullHeight = holder.height;
        list.init();
        addChild(list);

        var tf:TextFormat = new TextFormat()

        callbackTxt = new TextField(600, 200, "Callback text will appear here");
        callbackTxt.format.setTo("Fira Sans Semi-Bold 13", 13);
        callbackTxt.format.horizontalAlign = Align.LEFT;
        callbackTxt.format.verticalAlign = Align.TOP;
        callbackTxt.format.color = 0x666666;

        callbackTxt.batchable = false;
        callbackTxt.touchable = false;
        callbackTxt.x = 50;
        callbackTxt.y = 15;

        addChild(callbackTxt);

    }

    private function onExiting(event:Event):void {
        trace("exiting app");
        dtANE.dispose();
    }

    private function createLbl(txt:String, x:int, y:int):TextField {
        var lbl:TextField = new TextField(360, 200, txt);
        lbl.format.setTo("Fira Sans Semi-Bold 13", 13);
        lbl.format.horizontalAlign = Align.LEFT;
        lbl.format.verticalAlign = Align.TOP;
        lbl.format.color = 0x666666;
        lbl.x = x;
        lbl.y = y;
        return lbl;
    }

    private function onImage1Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image1);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var toast:ToastOSX = new ToastOSX();
            toast.hasActionButton = true;
            toast.title = "Dinner at 8?";
            toast.informativeText = "Pizza for 2!";
            toast.responsePlaceholder = "Please say yes";
            toast.hasReplyButton = true;
            toast.identifier = GUID.create();
            var userInfo:ANEObject = new ANEObject();
            userInfo.arguments = "reply";
            toast.userInfo = userInfo;

            dtANE.createFromToast(toast);
            dtANE.show();


        }
    }

    private function onImage2Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image2);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var toast:ToastOSX = new ToastOSX();
            toast.title = "Well Hello !";
            toast.subtitle = "This is your ANE speaking";
            toast.informativeText = "Check me out";
            toast.contentImage = File.applicationDirectory.resolvePath("imgs/air-icon.png").nativePath;
            toast.identifier = GUID.create();
            var userInfo:ANEObject = new ANEObject();
            userInfo.arguments = "view";
            toast.userInfo = userInfo;

            dtANE.createFromToast(toast);
            dtANE.show();
        }
    }

    private function onToastClicked(event:ToastEvent):void {
        trace(event);

        var window:NativeWindow = stage.starling.nativeStage.nativeWindow;
        if (window.displayState == NativeWindowDisplayState.MINIMIZED) {
            window.restore();
        }

        window.visible = true;

        NativeApplication.nativeApplication.activate();

        callbackTxt.text = "Toast Clicked - arguments: " + event.params.arguments;
        if (event.params.data) {
            for each(var kvp:Object in event.params.data) {
                callbackTxt.text += "\nkey: " + kvp.key;
                callbackTxt.text += "\nvalue: " + kvp.value;
            }
        }

        //handle protocol
        if (event.params.arguments) {
            var argsStr:String = event.params.arguments as String;
            if (argsStr.indexOf("protocol") == 0)
                navigateToURL(new URLRequest(argsStr.split("|")[1]));
        }

    }

}
}
