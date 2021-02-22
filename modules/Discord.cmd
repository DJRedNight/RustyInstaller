@echo off
call:%~1
goto exit

:: Handle Discord DLL Installation
:HandleDiscord
	call :InstallDiscordDLL
	goto:eof

:: Install Discord DLL Extension
:InstallDiscordDLL
	:: Grab the latest RustEditDLL File
	echo Downloading Latest Discord DLL File...
	powershell.exe -command "Invoke-WebRequest https://umod.org/extensions/discord/download -outfile RustServer\RustDedicated_Data\Managed\Oxide.Ext.Discord.dll"
	call modules/FlashMessage.cmd success "Grabbed Discord DLL Successfully from Releases!"

	call modules/FlashMessage.cmd success "Downloaded Discord DLL Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%