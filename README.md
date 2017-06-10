## DesktopToastANE

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6WW2HJLAQUBXU)

Adobe Air Native Extension written in ActionScript 3 and C++ for displaying adaptive and interactive toast notifications in Windows 8.1, Windows 10 and UserNotificiations on OSX 10.12.1.
Sample client included

![alt tag](https://raw.githubusercontent.com/tuarua/DesktopToastANE/master/screenshots/screenshot1.png)

![alt tag](https://raw.githubusercontent.com/tuarua/DesktopToastANE/master/screenshots/screenshot2.jpg)

### Features  
 - Adaptive and interactive toast notifications are new features added in Version 1607 of Windows 10.
 - Interactive toasts for Windows 8.1.
 - User notifications on OSX.

### Windows Installation - Important!

* This ANE was built with MS Visual Studio 2015. As such your machine (and user's machines) will need to have Microsoft Visual C++ 2015 Redistributable (x86) runtime installed.
https://www.microsoft.com/en-us/download/details.aspx?id=48145

### Tech

DesktopToastANE uses the following libraries:  
C++  
* [https://github.com/nlohmann/json/] - JSON for Modern C++

### Prerequisites

You will need
 
 - Flash Builder 4.7 or IntelliJ IDEA
 - AIR 25 SDK
 - MS Visual Studio 2015 if you wish to modify the ANE code on Windows
 - Xcode or AppCode if you wish to modify the ANE code on OSX

### Known Issues
You should use a different appName when debugging. The required .lnk file created in \AppData\Roaming\Microsoft\Windows\Start Menu\Programs will point to adl initially.

### Todos
Complete ASdocs

### References
https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/07/02/adaptive-and-interactive-toast-notifications-for-windows-10/  
https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/10/16/quickstart-handling-toast-activations-from-win32-apps-in-windows-10/  
https://github.com/WindowsNotifications/desktop-toasts    
