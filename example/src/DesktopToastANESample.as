package {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.system.Capabilities;

import starling.core.Starling;
import starling.events.Event;


[SWF(width="1024", height="720", frameRate="60", backgroundColor="#F1F1F1")]
public class DesktopToastANESample extends Sprite {
    public var mStarling:Starling;

    public function DesktopToastANESample() {

        super();

        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        Starling.multitouchEnabled = false;
        var viewPort:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);


        var isSupported:Boolean = false;

        if (Capabilities.os.toLowerCase() == "windows 10") {
            mStarling = new Starling(StarlingRoot_Win10, stage, viewPort, null, "auto", "auto");
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
                    function onRootCreated(event:Object, app:StarlingRoot_Win10):void {
                        mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                        app.start();
                        mStarling.start();
                    });
            isSupported = true;
        } else if (Capabilities.os.toLowerCase() == "windows 8") {
            mStarling = new Starling(StarlingRoot_Win8, stage, viewPort, null, "auto", "auto");
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
                    function onRootCreated(event:Object, app:StarlingRoot_Win8):void {
                        mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                        app.start();
                        mStarling.start();
                    });
            isSupported = true;
        } else if (Capabilities.os.toLowerCase().indexOf("mac os") > -1) {
            mStarling = new Starling(StarlingRoot_OSX, stage, viewPort, null, "auto", "auto");
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
                    function onRootCreated(event:Object, app:StarlingRoot_OSX):void {
                        mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
                        app.start();
                        mStarling.start();
                    });
            isSupported = true;
        }

        if (isSupported) {
            mStarling.stage.stageWidth = stage.stageWidth;  // <- same size on all devices!
            mStarling.stage.stageHeight = stage.stageHeight;
            mStarling.simulateMultitouch = false;
            mStarling.showStatsAt("right", "bottom");
            mStarling.enableErrorChecking = false;
            mStarling.antiAliasing = 16;
            mStarling.skipUnchangedFrames = true;
        }


        NativeApplication.nativeApplication.executeInBackground = true;

    }

}
}