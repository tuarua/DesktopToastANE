$currentDir = (Get-Item -Path ".\" -Verbose).FullName
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://github.com/tuarua/Swift-IOS-ANE/releases/download/4.1.0/FreSwift.ane?raw=true -OutFile "$currentDir\..\native_extension/ane/FreSwift.ane"
