@echo off
call:%~1
goto exit

:: Handle Rust Edit Installation
:HandleRustEdit
	call :InstallRustEditDLL
	goto:eof

:: Install RustEditDLL
:InstallRustEditDLL
	:: Grab the latest RustEditDLL File
	echo Downloading Latest RustEdit DLL File...
	powershell.exe -command "Invoke-WebRequest https://github.com/k1lly0u/Oxide.Ext.RustEdit/raw/master/Oxide.Ext.RustEdit.dll -outfile RustServer\RustDedicated_Data\Managed\Oxide.Ext.RustEdit.dll"
	call modules/FlashMessage.cmd success "Grabbed RustEditDLL Successfully from Releases!"

	call modules/FlashMessage.cmd success "Downloaded RustEdit DLL Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%