@echo off
call:%~1
goto exit

:: Handle Steam Installation
:HandleOxide
	call :InstallOxide
	goto:eof

:: Install Oxide for Rust
:InstallOxide
	:: Grab the latest Oxide For Rust ZIP File
	echo Downloading Latest Oxide for Rust Build...
	powershell.exe -command "Invoke-WebRequest https://github.com/OxideMod/Oxide.Rust/releases/latest/download/Oxide.Rust.zip -outfile temp\oxide.zip"
	call modules/FlashMessage.cmd success "Grabbed Oxide Successfully from Releases!"

	:: Unzip The ZIP file
	echo Unzipping the Oxide for Rust ZIP File
	powershell.exe Expand-Archive -Force temp\oxide.zip -DestinationPath RustServer
	call modules/FlashMessage.cmd success "Unzipped the file successfully!"

	call modules/FlashMessage.cmd success "Downloaded Oxide for Rust Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%