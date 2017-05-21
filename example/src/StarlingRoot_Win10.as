package {

import com.tuarua.DesktopToastANE;
import com.tuarua.toast.ToastEvent;
import com.tuarua.toast.constants.ToastActivationType;
import com.tuarua.toast.constants.ToastAudioSrc;
import com.tuarua.toast.constants.ToastHintCrop;
import com.tuarua.toast.constants.ToastInputSelection;
import com.tuarua.toast.constants.ToastInputType;
import com.tuarua.toast.constants.ToastPlacement;
import com.tuarua.toast.constants.ToastScenario;
import com.tuarua.toast.windows.ToastAudio;
import com.tuarua.toast.windows.ToastImage;
import com.tuarua.toast.windows.ToastText;
import com.tuarua.toast.windows10.ToastAction;
import com.tuarua.toast.windows10.ToastInput;
import com.tuarua.toast.windows10.Toast10;
import com.tuarua.windows10;

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

import views.ScrollableContent;

// https://gist.github.com/kirancheraku/512f658da1847044a7b6
// https://msdn.microsoft.com/en-us/library/windows/desktop/mt643715(v=vs.85).aspx
// https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/07/02/adaptive-and-interactive-toast-notifications-for-windows-10/
// https://unsplash.it/360/180?image=1043
// https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/10/16/quickstart-handling-toast-activations-from-win32-apps-in-windows-10/
// https://github.com/WindowsNotifications/desktop-toasts/blob/master/CPP/DesktopToastsSample.cpp


//https://gist.github.com/CalvinLinTrend/8701312744f94bcd8701 -
public class StarlingRoot_Win10 extends Sprite {
    private var dtANE:DesktopToastANE;
    private var image1:Image = new Image(Assets.getAtlas().getTexture("air_rocks"));
    private var image2:Image = new Image(Assets.getAtlas().getTexture("actions1"));
    private var image3:Image = new Image(Assets.getAtlas().getTexture("actions2"));
    private var image4:Image = new Image(Assets.getAtlas().getTexture("textinput1"));
    private var image5:Image = new Image(Assets.getAtlas().getTexture("textinput2"));
    private var image6:Image = new Image(Assets.getAtlas().getTexture("selection1"));
    private var image7:Image = new Image(Assets.getAtlas().getTexture("reminder1"));
    private var list:ScrollableContent;
    private var holder:Sprite = new Sprite();
    private var callbackTxt:TextField;

    use namespace windows10;

    public function StarlingRoot_Win10() {
        super();
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
    }

    public function start(dtANE:DesktopToastANE):void {
		this.dtANE = dtANE;
        NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, onExiting);

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
        holder.addChild(createLbl("Notification with rich visual contents\nYou can have multiple lines of text, an " +
                "optional small image to override the application logo, and an optional inline image thumbnail in " +
                "a toast.", 400, 0));

        image2.addEventListener(TouchEvent.TOUCH, onImage2Touch);
        image2.useHandCursor = true;
        image2.y = image1.height + 20;
        holder.addChild(image2);

        holder.addChild(createLbl("Notification with actions (sample 1)", 400, image2.y));

        image3.addEventListener(TouchEvent.TOUCH, onImage3Touch);
        image3.useHandCursor = true;
        image3.y = image2.y + image2.height + 20;
        holder.addChild(image3);
        holder.addChild(createLbl("Notification with actions (sample 2)\nIn this sample you can open a browser url or " +
                "app url", 400, image3.y));

        image4.addEventListener(TouchEvent.TOUCH, onImage4Touch);
        image4.useHandCursor = true;
        image4.y = image3.y + image3.height + 20;
        holder.addChild(image4);
        holder.addChild(createLbl("Notification with text input and actions (sample 1)\nIn this sample, you can add " +
                "a textbox that allows the user to input text.", 400, image4.y));

        image5.addEventListener(TouchEvent.TOUCH, onImage5Touch);
        image5.useHandCursor = true;
        image5.y = image4.y + image4.height + 20;
        holder.addChild(image5);
        holder.addChild(createLbl("Notification with text input and actions (sample 2)\nIf allowing user to reply " +
                "with text input is the only scenario you care about, you can also use the below layout. This only " +
                "works if your action specifies an image icon.", 400, image5.y));

        image6.addEventListener(TouchEvent.TOUCH, onImage6Touch);
        image6.useHandCursor = true;
        image6.y = image5.y + image5.height + 20;
        holder.addChild(image6);
        holder.addChild(createLbl("Notification with selection input and actions\nIn this sample, you can add a " +
                "dropdown list with pre-defined selections for the user to select.", 400, image6.y));

        image7.addEventListener(TouchEvent.TOUCH, onImage7Touch);
        image7.useHandCursor = true;
        image7.y = image6.y + image6.height + 20;
        holder.addChild(image7);
        holder.addChild(createLbl("Reminder Notification\nINotifications with scenario “reminder” will appear " +
                "pre-expanded and remain on the user’s screen till dismissed or interacted with.", 400, image7.y));

        list = new ScrollableContent(840, 600, holder);
        list.x = 50;
        list.y = 90;
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

    private function onToastDismissed(event:ToastEvent):void {
        callbackTxt.text = "Toast Dismissed";
    }

    private function onToastError(event:ToastEvent):void {
        callbackTxt.text = "Toast Error";
    }

    private function onToastHidden(event:ToastEvent):void {
        callbackTxt.text = "Toast Hidden"; //TODO
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
            var toast:Toast10 = new Toast10("rocks");
            toast.addText(new ToastText("Adobe Air Rocks"));
            toast.addText(new ToastText("Trigger Toasts in Windows 10"));
            toast.addText(new ToastText("with this AIR Native Extension"));

            var toastImage2:ToastImage = new ToastImage();
            toastImage2.src = File.applicationDirectory.resolvePath("imgs/air-icon.png").nativePath;
            toastImage2.placement = ToastPlacement.APP_LOGO_OVERRIDE;
            toastImage2.hintCrop = ToastHintCrop.CIRCLE;

            toast.addImage(new ToastImage(File.applicationDirectory.resolvePath("imgs/air.png").nativePath));
            toast.addImage(toastImage2);

            toast.addAudio(new ToastAudio(ToastAudioSrc.IM));

            dtANE.createFromToast(toast);
            dtANE.show();


        }
    }

    private function onImage2Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image2);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = XML(<toast launch="app-defined-string">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Microsoft Company Store</text>
                                <text>New Halo game is back in stock!</text>
                            </binding>
                        </visual>
                        <actions>
                            <action activationType="foreground" content="See more details" arguments="details"/>
                            <action activationType="background" content="Remind me later" arguments="later"/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10("app-defined-string");
            toast.addText(new ToastText("Microsoft Company Store"));
            toast.addText(new ToastText("New Halo game is back in stock!"));

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.content = "See more details";
            toastAction1.arguments = "details";

            var toastAction2:ToastAction = new ToastAction();
            toastAction2.activationType = ToastActivationType.BACKGROUND;
            toastAction2.arguments = "later";
            toastAction2.content = "Remind me later";

            toast.addAction(toastAction1);
            toast.addAction(toastAction2);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onImage3Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image3);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = XML(
                    <toast launch="app-defined-string">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Restaurant suggestion...</text>
                                <text>We noticed that you are near Wasaki. Thomas left a 5 star rating after his last
                                    visit, do you want to try it?
                                </text>
                            </binding>
                        </visual>
                        <actions>
                            <action activationType="foreground" content="Reviews" arguments="reviews"/>
                            <action activationType="protocol" content="Show map"
                                    arguments="protocol|bingmaps:?q=sushi"/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10("app-defined-string");
            toast.addText(new ToastText("Restaurant suggestion..."));
            toast.addText(new ToastText("We noticed that you are near Wasaki. Thomas left a 5 star rating after his last visit, do you want to try it?"));

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.content = "Reviews";
            toastAction1.arguments = "reviews";

            var toastAction2:ToastAction = new ToastAction();
            toastAction2.activationType = ToastActivationType.PROTOCOL;
            toastAction2.arguments = "protocol|bingmaps:?q=sushi"; //this is a workaround for the fact that protocol is not triggering when using COM server
            toastAction2.content = "Show map";

            toast.addAction(toastAction1);
            toast.addAction(toastAction2);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onImage4Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image4);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = XML(
                    <toast launch="developer-defined-string">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Andrew B.</text>
                                <text>Shall we meet up at 8?</text>
                                <image placement="appLogoOverride" src="" hint-crop="circle"/>
                            </binding>
                        </visual>
                        <actions>
                            <input id="message" type="text" placeHolderContent="Type a reply"/>
                            <action activationType="background" content="Reply" arguments="reply"/>
                            <action activationType="foreground" content="Video call" arguments="video"/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10("developer-defined-string");
            toast.addText(new ToastText("Andrew B."));
            toast.addText(new ToastText("Shall we meet up at 8?"));


            var toastImage1:ToastImage = new ToastImage();
            toastImage1.src = File.applicationDirectory.resolvePath("app-icon.jpg").nativePath;
            toastImage1.placement = ToastPlacement.APP_LOGO_OVERRIDE;
            toastImage1.hintCrop = ToastHintCrop.CIRCLE;

            var toastInput:ToastInput = new ToastInput();
            toastInput.id = "message";
            toastInput.placeHolderContent = "Type a reply";

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.activationType = ToastActivationType.BACKGROUND;
            toastAction1.content = "Reply";
            toastAction1.arguments = "reply";

            var toastAction2:ToastAction = new ToastAction();
            toastAction2.activationType = ToastActivationType.FOREGROUND;
            toastAction2.arguments = "video";
            toastAction2.content = "Video call";

            toast.addImage(toastImage1);
            toast.addInput(toastInput);
            toast.addAction(toastAction1);
            toast.addAction(toastAction2);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onImage5Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image5);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = new XML(
                    <toast launch="developer-defined-string">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Andrew B.</text>
                                <text>Shall we meet up at 8?</text>
                                <image placement="appLogoOverride"
                                       src="D:\dev\flash\DesktopToastANE\example\src\app-icon.jpg" hint-crop="circle"/>
                            </binding>
                        </visual>
                        <actions>
                            <input id="message" type="text" placeHolderContent="Type a reply"/>
                            <action activationType="background" content="Reply" arguments="reply" hint-inputId="message"
                                    imageUri="D:\dev\flash\DesktopToastANE\example\src\send.png"/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10("developer-defined-string");
            toast.addText(new ToastText("Andrew B."));
            toast.addText(new ToastText("Shall we meet up at 8?"));

            var toastImage1:ToastImage = new ToastImage();
            toastImage1.src = File.applicationDirectory.resolvePath("imgs/app-icon.jpg").nativePath;
            toastImage1.placement = ToastPlacement.APP_LOGO_OVERRIDE;
            toastImage1.hintCrop = ToastHintCrop.CIRCLE;

            var toastInput:ToastInput = new ToastInput();
            toastInput.type = ToastInputType.TEXT;
            toastInput.placeHolderContent = "Type a reply";
            toastInput.id = "message";

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.activationType = ToastActivationType.BACKGROUND;
            toastAction1.content = "Reply";
            toastAction1.arguments = "reply";
            toastAction1.hintInputId = "message";
            toastAction1.imageUri = File.applicationDirectory.resolvePath("imgs/send.png").nativePath;

            toast.addImage(toastImage1);
            toast.addInput(toastInput);
            toast.addAction(toastAction1);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onImage6Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image6);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = XML(
                    <toast launch="developer-defined-string">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Spicy Heaven</text>
                                <text>When do you plan to come in tomorrow?</text>
                            </binding>
                        </visual>
                        <actions>
                            <input id="time" type="selection" defaultInput="2">
                                <selection id="1" content="Breakfast"/>
                                <selection id="2" content="Lunch"/>
                                <selection id="3" content="Dinner"/>
                            </input>
                            <action activationType="background" content="Reserve" arguments="reserve"/>
                            <action activationType="foreground" content="Call Restaurant" arguments="call"/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10("developer-defined-string");
            toast.addText(new ToastText("Spicy Heaven"));
            toast.addText(new ToastText("When do you plan to come in tomorrow?"));

            var toastInput:ToastInput = new ToastInput();
            toastInput.type = ToastInputType.SELECTION;
            toastInput.defaultInput = "2";
            toastInput.id = "time";

            toastInput.addSelection(new ToastInputSelection("1", "Breakfast"));
            toastInput.addSelection(new ToastInputSelection("2", "Lunch"));
            toastInput.addSelection(new ToastInputSelection("3", "Dinner"));

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.activationType = ToastActivationType.BACKGROUND;
            toastAction1.content = "Reserve";
            toastAction1.arguments = "reserve";

            var toastAction2:ToastAction = new ToastAction();
            toastAction2.activationType = ToastActivationType.FOREGROUND;
            toastAction2.content = "Call Restaurant";
            toastAction2.arguments = "call";

            toast.addInput(toastInput);
            toast.addAction(toastAction1);
            toast.addAction(toastAction2);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onImage7Touch(event:TouchEvent):void {
        var touch:Touch = event.getTouch(image7);
        if (touch != null && touch.phase == TouchPhase.ENDED) {
            var xml:XML = XML(
                    <toast scenario="reminder" launch="action=viewEvent&amp;eventId=1983">
                        <visual>
                            <binding template="ToastGeneric">
                                <text>Adaptive Tiles Meeting</text>
                                <text>Conf Room 2001 / Building 135</text>
                                <text>10:00 AM - 10:30 AM</text>
                            </binding>
                        </visual>
                        <actions>
                            <input id="snoozeTime" type="selection" defaultInput="15">
                                <selection id="1" content="1 minute"/>
                                <selection id="15" content="15 minutes"/>
                                <selection id="60" content="1 hour"/>
                                <selection id="240" content="4 hours"/>
                                <selection id="1440" content="1 day"/>
                            </input>
                            <action activationType="system" arguments="snooze" hint-inputId="snoozeTime" content=""/>
                            <action activationType="system" arguments="dismiss" content=""/>
                        </actions>
                    </toast>
            );
            var toast:Toast10 = new Toast10();
            toast.launch = "action=viewEvent&amp;eventId=1983";
            toast.scenario = ToastScenario.REMINDER;

            toast.addText(new ToastText("Adaptive Tiles Meeting"));
            toast.addText(new ToastText("Conf Room 2001 / Building 135"));
            toast.addText(new ToastText("10:00 AM - 10:30 AM"));

            var toastInput:ToastInput = new ToastInput();
            toastInput.type = ToastInputType.SELECTION;
            toastInput.defaultInput = "15";
            toastInput.id = "snoozeTime";

            toastInput.addSelection(new ToastInputSelection("1", "1 minute"));
            toastInput.addSelection(new ToastInputSelection("15", "15 minutes"));
            toastInput.addSelection(new ToastInputSelection("60", "1 hour"));
            toastInput.addSelection(new ToastInputSelection("240", "4 hours"));
            toastInput.addSelection(new ToastInputSelection("1440", "1 day"));

            var toastAction1:ToastAction = new ToastAction();
            toastAction1.activationType = ToastActivationType.SYSTEM;
            toastAction1.hintInputId = "snoozeTime";
            toastAction1.arguments = "snooze";
            toastAction1.content = "";

            var toastAction2:ToastAction = new ToastAction();
            toastAction2.activationType = ToastActivationType.SYSTEM;
            toastAction2.arguments = "dismiss";
            toastAction2.content = "";

            toast.addInput(toastInput);
            toast.addAction(toastAction1);
            toast.addAction(toastAction2);

            dtANE.createFromToast(toast);
            //dtANE.createFromXML(xml); //or use xml
            dtANE.show();
        }
    }

    private function onExiting(event:Event):void {
        trace("exiting app");
        dtANE.dispose();
    }

}
}




