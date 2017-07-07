/**
 * Created by User on 11/12/2016.
 */
package com.tuarua.toast.osx {

public class ToastOSX {
    /**
     *
     * Specifies the title of the notification.
     *
     */
    public var title:String;
    /**
     *
     * Specifies the subtitle of the notification.
     *
     */
    public var subtitle:String;
    /**
     *
     * The body text of the notification.
     *
     */
    public var informativeText:String;

    /**
     *
     * Image shown in the content of the notification.
     *
     */
    public var contentImage:String;
    /**
     *
     * Identifier for a notification.
     *
     */
    public var identifier:String;
    /**
     *
     * Optional placeholder string for inline reply field.
     *
     */
    public var responsePlaceholder:String;
    /**
     *
     * A Boolean value that specifies whether the notification displays an action button.
     *
     */
    public var hasActionButton:Boolean = false;
    /**
     *
     * A Boolean value that specifies whether the notification displays a reply button.
     *
     */
    public var hasReplyButton:Boolean = false;
    /**
     *
     * Specifies the title of the action button displayed in the notification.
     *
     */
    public var actionButtonTitle:String;
    /**
     *
     * Specifies a custom title for the close button in an alert-style notification.
     *
     */
    public var otherButtonTitle:String;
    /**
     *
     * A Boolean value that specifies whether to play a sound when the notification is delivered.
     *
     */
    public var playSound:Boolean = true;

    /**
     *
     * Application-specific user info that can be attached to the notification.
     *
     */
    public var userInfo:UserInfo;

    public function ToastOSX() {
        super();
    }


}
}

