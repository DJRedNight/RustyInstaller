@echo off
call:%~1
goto exit

:: Handle Steam Installation
:HandleSteamInstall
	call :DownloadSteamCMD
	call :RunSteamCMD
	goto:eof

:: Download Steam CMD
:DownloadSteamCMD
	echo "Downloading SteamCMD..."

	if exist %cd%\Steam\steamcmd.exe (
		call modules/FlashMessage.cmd warning "SteamCMD Already Exists. No need to download it again."
		exit /B %ERRORLEVEL%
	)

	:: Grab the latest SteamCMD ZIP File
	echo Grabbing the latest SteamCMD zip file from Valve
	powershell.exe -command "Invoke-WebRequest https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -outfile temp\steamcmd.zip"
	call modules/FlashMessage.cmd success "Grabbed SteamCMD Successfully!"

	:: Unzip The ZIP file
	echo Unzipping the SteamCMD ZIP File
	powershell.exe Expand-Archive -Force temp\steamcmd.zip -DestinationPath Steam
	call modules/FlashMessage.cmd success "Unzipped the file successfully!"

	call modules/FlashMessage.cmd success "Downloaded SteamCMD Successfully!"
	timeout /t 3

	exit /B %ERRORLEVEL%

:: Run SteamCMD Function
:RunSteamCMD
	echo Running SteamCMD and Installing Rust Server Files
	%cd%\Steam\steamcmd.exe ^
	+login anonymous ^
	+force_install_dir %cd%\RustServer ^
	+app_update 258550 ^
	+quit
	call modules/FlashMessage.cmd success "Installed Steam and Rust Server Files Successfully!"
	exit /B %ERRORLEVEL%

:: Update Steam & Rust Server Files
:UpdateSteamCMD
	echo Running SteamCMD and Updating Rust Server Files
	%cd%\Steam\steamcmd.exe ^
	+login anonymous ^
	+force_install_dir %cd%\RustServer ^
	+app_update 258550 ^
	+quit
	call modules/FlashMessage.cmd success "Updated Steam and Rust Server Files Successfully!"
	timeout /t 5
	goto:eof

:: Reinstall Rust
:ReinstallRust
	SETLOCAL EnableDelayedExpansion
	echo Reinstalling Rust Server will wipe ALL data from your machine. This process can NOT be reversed. Make sure to backup your files before continuing.
	choice /C:yn /t 5 /D n /N /M "Continue? (Y/N)"
	if !ERRORLEVEL! ==2 (
		call modules/FlashMessage.cmd alert "Aborting the re-install. Bringing you back to the main menu."
		timeout /t 5
		exit /B %ERRORLEVEL%
	)
	call modules/Directories.cmd RemoveRustServerDirectory

	:: Create All Working Directories
	call modules/Directories.cmd CreateDirectories

	call :UpdateSteamCMD

	call modules/Oxide.cmd HandleOxide
	call modules/RustEdit.cmd HandleRustEdit

	call modules/Directories.cmd RemoveTempDirectory
	:: Start Server
	call modules/RustServer.cmd FirstStart
	exit /B %ERRORLEVEL%

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%