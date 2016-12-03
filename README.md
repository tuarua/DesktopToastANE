# DesktopToastANE

Adobe Air Native Extension written in ActionScript 3 and C++ for displaying adaptive and interactive toast notifications in Windows 10.
Sample client included

![alt tag](https://raw.githubusercontent.com/tuarua/DesktopToastANE/master/screenshots/screenshot1.png)

### Features  
 - Adaptive and interactive toast notifications are new features added in Version 1607 of Windows 10
 - Windows 8.1 is not supported as this ANE was compiled with Windows 10 libraries. This may be provided at a later date.

### Tech

DesktopToastANE uses the following libraries:  
C++  
* [https://github.com/nlohmann/json/] - JSON for Modern C++

### Prerequisites

You will need
 
 - Flash Builder 4.7 or IntelliJ IDEA
 - AIR 23 SDK
 - MS Visual Studio 2015 if you wish to modify the ANE code on Windows


### Known Issues
You should use a different appName when debugging. The required .lnk file created in \AppData\Roaming\Microsoft\Windows\Start Menu\Programs will point to adl initially.

### Todos
Complete ASdocs

### References
https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/07/02/adaptive-and-interactive-toast-notifications-for-windows-10/  
https://blogs.msdn.microsoft.com/tiles_and_toasts/2015/10/16/quickstart-handling-toast-activations-from-win32-apps-in-windows-10/  
https://github.com/WindowsNotifications/desktop-toasts    
