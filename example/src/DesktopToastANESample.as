package {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;


[SWF(width = "1024", height = "720", frameRate = "60", backgroundColor = "#F1F1F1")]
public class DesktopToastANESample extends Sprite {
    public var mStarling:Starling;
    public function DesktopToastANESample(){

        super();

        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        Starling.multitouchEnabled = false;
        trace(Starling.VERSION);
        var viewPort:Rectangle = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
        mStarling = new Starling(StarlingRoot, stage, viewPort,null,"auto","auto");
        mStarling.stage.stageWidth = stage.stageWidth;  // <- same size on all devices!
        mStarling.stage.stageHeight = stage.stageHeight;
        mStarling.simulateMultitouch = false;
        mStarling.showStatsAt("right","bottom");
        mStarling.enableErrorChecking = false;
        mStarling.antiAliasing = 16;
        mStarling.skipUnchangedFrames = true;

        mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
                function onRootCreated(event:Object, app:StarlingRoot):void {
                    mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                    app.start();
                    mStarling.start();
                });

        NativeApplication.nativeApplication.executeInBackground = true;

    }

}
}



/*
package {
import com.tuarua.DesktopToastANE;
import com.tuarua.toast.Toast;
import com.tuarua.toast.ToastAction;
import com.tuarua.toast.ToastAudio;
import com.tuarua.toast.ToastImage;
import com.tuarua.toast.ToastText;
import com.tuarua.toast.constants.ActivationType;
import com.tuarua.toast.constants.AudioSrc;
import com.tuarua.toast.constants.Duration;
import com.tuarua.toast.constants.HintCrop;
import com.tuarua.toast.constants.Placement;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filesystem.File;

public class DesktopToastANESample extends Sprite {



    //https://msdn.microsoft.com/en-us/library/windows/apps/br230842.aspx?f=255&MSPPError=-2147217396
    private var dtANE:DesktopToastANE = new DesktopToastANE();
    private var btn:Sprite = new Sprite();

    public function DesktopToastANESample() {
        btn.graphics.beginFill(0x000000);
        btn.graphics.drawRect(50, 50, 100, 100);
        btn.graphics.endFill();
        btn.addEventListener(MouseEvent.CLICK, onClick);
        addChild(btn);
        trace(File.applicationDirectory.resolvePath("app-icon.jpg").nativePath);
        dtANE.init("Microsoft.Samples.DesktopToasts");
    }

    protected function onClick(event:MouseEvent):void {
 var toast:Toast = new Toast();
 toast.addText(new ToastText("Photo Share"));
 toast.addText(new ToastText("Eoin sent you a picture"));

 var toastImage1:ToastImage = new ToastImage();



 toastImage1.src = File.applicationDirectory.resolvePath("app-icon.jpg").nativePath;
 toastImage1.placement = Placement.APP_LOGO_OVERRIDE;
 toastImage1.hintCrop = HintCrop.CIRCLE;

 toast.addImage(toastImage1);

 var toastAction1:ToastAction = new ToastAction();
 toastAction1.content = "See more details";
 toastAction1.arguments = "details";
 var toastAction2:ToastAction = new ToastAction();
 toastAction2.activationType = ActivationType.PROTOCOL;
 toastAction2.content = "Show map";
 toastAction2.arguments = "bingmaps:?q=sushi";

 toast.addAction(toastAction1);
 toast.addAction(toastAction2);

 var audio:ToastAudio = new ToastAudio();
 audio.src = AudioSrc.REMINDER;
 toast.addAudio(audio);

        var xml:XML;
        xml = <toast>
            <visual>
                <binding template="ToastGeneric">
                    <text>Photo Share</text>
                    <text>Eoin sent you a picture</text>
                    <image placement="AppLogoOverride" hint-crop="circle" src="D:\\toastImageAndText.png"/>
                </binding>
            </visual>
            <actions>
                <action activationType="foreground" content="See more details" arguments="details"/>
                <action activationType="protocol" content="Show map" arguments="bingmaps:?q=sushi"/>
            </actions>
            <audio src="ms-winsoundevent:Notification.Reminder"/>
        </toast>;

        //dtANE.createFromXML(xml);
        dtANE.createFromToast(toast);
        dtANE.show();
    }
}
}
        */