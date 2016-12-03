REM Get the path to the script and trim to get the directory.
@echo off
SET projectName=DesktopToastANE
echo Setting path to current directory to:
SET pathtome=%~dp0
echo %pathtome%

echo build asdocs
call asdoc ^
-doc-sources %pathtome%..\src ^
-source-path %pathtome%..\src ^
-window-title "Tua Rua %projectName%" ^
-main-title "Tua Rua %projectName% Documentation" ^
-output %pathtome%..\docs\asdocs ^
-lenient ^
-library-path+=D:\dev\sdks\AIR\4.6.0_23\frameworks\libs\air\airglobal.swc

call asdoc ^
-doc-sources %pathtome%..\src ^
-source-path %pathtome%..\src ^
-window-title "Tua Rua %projectName%" ^
-main-title "Tua Rua %projectName% Documentation" ^
-output %pathtome%..\docs\tmp ^
-lenient -keep-xml=true -skip-xsl=true ^
-library-path+=D:\dev\sdks\AIR\4.6.0_23\frameworks\libs\air\airglobal.swc

call DEL /F /S /Q /A %pathtome%..\docs\tmp\tempdita\ASDoc_Config.xml
call DEL /F /S /Q /A %pathtome%..\docs\tmp\tempdita\overviews.xml

call rd /S /Q %pathtome%docs
move %pathtome%..\docs\tmp\tempdita %pathtome%docs
call rd /S /Q %pathtome%..\docs\tmp