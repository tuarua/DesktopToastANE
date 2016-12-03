REM Get the path to the script and trim to get the directory.
@echo off
SET pathtome=%~dp0
SET ADL_PATH="D:\dev\sdks\AIR\AIRSDK_23\bin\adl"

IF NOT EXIST ADL_PATH echo Please set AIR SDK path

echo Running
call %ADL_PATH% -profile extendedDesktop -extdir %pathtome%/../native_extension/ane/debug/ -nodebug %pathtome%/bin-debug/DesktopToastANESample-app.xml