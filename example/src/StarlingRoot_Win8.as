package {

import com.tuarua.DesktopToastANE;
import com.tuarua.toast.ToastEvent;
import com.tuarua.toast.constants.ToastAudioSrc;
import com.tuarua.toast.constants.ToastDuration;
import com.tuarua.toast.windows.ToastAudio;
import com.tuarua.toast.windows.ToastImage;
import com.tuarua.toast.windows.ToastText;
import com.tuarua.toast.windows8.Toast8;
import com.tuarua.toast.windows8.ToastCommand;
import com.tuarua.toast.windows8.ToastCommands;
import com.tuarua.windows8;

import flash.desktop.NativeApplication;
import flash.display.NativeWindow;
import flash.display.NativeWindowDisplayState;
import flash.filesystem.File;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.Align;

import views.ScrollableContent;

// https://gist.github.com/kirancheraku/512f658da1847044a7b6
// https://msdn.microsoft.com/en-us/library/windows/desktop/mt643715(v=vs.85).aspx
// https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/07/02/adaptive-and-interactive-toast-notifications-for-windows-10/
// https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/10/16/quickstart-handling-toast-activations-from-win32-apps-in-windows-10/
// https://github.com/WindowsNotifications/desktop-toasts/blob/master/CPP/DesktopToastsSample.cpp

//https://msdn.microsoft.com/en-us/library/windows/apps/dn268318.aspx


//https://gist.github.com/CalvinLinTrend/8701312744f94bcd8701 -
public class StarlingRoot_Win8 extends Sprite {
    private var dtANE:DesktopToastANE;
    private var image1:Image = new Image(Assets.getAtlas().getTexture("air_rocks"));
    private var image7:Image = new Image(Assets.getAtlas().getTexture("reminder1"));
    private var holder:Sprite = new Sprite();
    private var callbackTxt:TextField;

    use namespace windows8;

    public function StarlingRoot_Win8() {
        super();
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
    }

    public function start(dtANE:DesktopToastANE):void {
        this.dtANE = dtANE;

        dtANE.init(NativeApplication.nativeApplication.applicationID, "Toast ANE Sample");
        dtANE.addEventListener(ToastEvent.TOAST_CLICKED, onToastClicked);
        dtANE.addEventListener(ToastEvent.TOAST_DISMISSED, onToastDismissed);
        dtANE.addEventListener(ToastEvent.TOAST_ERROR, onToastError);
        dtANE.addEventListener(ToastEvent.TOAST_HIDDEN, onToastHidden);
        dtANE.addEventListener(ToastEvent.TOAST_NOT_ACTIVATED, onToastNotActivated);
        dtANE.addEventListener(ToastEvent.TOAST_TIMED_OUT, onToastTimedOut);

        image1.addEventListener(TouchEvent.TOUCH, onImage1Touch);
        image1.useHandCursor = true;
        holder.addChild(image1);
        holder.addChild(createLabel("Notification with rich visual contents\nYou can have multiple lines of text, an " +
                "optional small image to override the application logo, and an optional inline image thumbnail in " +
                "a toast.", 400, 0));


        image7.addEventListener(TouchEvent.TOUCH, onImage7Touch);
        image7.useHandCursor = true;
        image7.y = image1.y + image1.height + 20;
        holder.addChild(image7);
        holder.addChild(createLabel("Reminder Notification\nINotifications with scenario “reminder” will appear " +
                "pre-expanded and remain on the user’s screen till dismissed or interacted with.", 400, image7.y));


        var list:ScrollableContent = new ScrollableContent(840, 600, holder);
        list.x = 50;
        list.y = 90;
        list.fullHeight = holder.height;
        list.init();
        addChild(list);

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


    private function createLabel(txt:String, x:int, y:int):TextField {
        var lbl:TextField = new TextField(360, 200, txt);
        lbl.format.setTo("Fira Sans Semi-Bold 13", 13);
        lbl.format.horizontalAlign = Align.LEFT;
        lbl.format.verticalAlign = Align.TOP;
        lbl.format.color = 0x666666;
        lbl.x = x;
        lbl.y = y;
        return lbl;
    }


    private function onToastClicked(event:ToastEvent):void {
        trace(event);

        var window:NativeWindow = stage.starling.nativeStage.nativeWindow;
        if (window.displayState == NativeWindowDisplayState.MINIMIZED) {
            window.restore();
        }

        window.visible = true;


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

    private function onToastDismissed(event:ToastEvent):void {
        callbackTxt.text = "Toast Dismissed";
    }

    private function onToastError(event:ToastEvent):void {
        callbackTxt.text = "Toast Error";
    }

    private function onToastHidden(event:ToastEvent):void {
        callbackTxt.text = "Toast Hidden";
    }

    private function onToastNotActivated(event:ToastEvent):void {
        callbackTxt.text = "Toast Not Activated";
    }

    private function onToastTimedOut(event:ToastEvent):void {
        callbackTxt.text = "Toast Timed Out";
    }


    private function onImage1Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image1);

        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var toast:Toast8 = new Toast8("rocks");
            toast.addText(new ToastText("Adobe AIR rocks"));
            toast.addText(new ToastText("Trigger Toasts in Windows 8"));
            toast.addText(new ToastText("with this AIR Native Extension"));
            var toastImage2:ToastImage = new ToastImage();
            toastImage2.src = File.applicationDirectory.resolvePath("imgs/air-icon.png").nativePath;
            toast.addImage(toastImage2);

            dtANE.createFromToast(toast);
            dtANE.show();


        }
    }


    private function onImage7Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image7);
        if (touch != null && touch.phase == TouchPhase.ENDED) {

            var toast:Toast8 = new Toast8();
            toast.duration = ToastDuration.LONG;


            toast.addText(new ToastText("Alarms Notifications SDK Sample App", null, 0, 1));
            toast.addText(new ToastText("alarmName", null, 0, 2));

            var commands:ToastCommands = new ToastCommands("alarm");
            var command1:ToastCommand = new ToastCommand("snooze");
            var command2:ToastCommand = new ToastCommand("dismiss");

            commands.addCommand(command1);
            commands.addCommand(command2);

            toast.commands = commands;

            var audio:ToastAudio = new ToastAudio(ToastAudioSrc.ALARM2);

            dtANE.createFromToast(toast);
            dtANE.show();
        }
    }


}
}




