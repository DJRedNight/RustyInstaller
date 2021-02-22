@echo off
SETLOCAL EnableDelayedExpansion
call:%~1
goto exit

:InvokeMenu (
	:: Change the text to green
	echo [92m

	:: Check if this is the first time running the script
	call :CheckForFirstRun

	:: First Check Not Detected, Show User The Main Menu
	call :MainMenu

	:: Clear The Text Color
	echo [0m
	goto:eof
)

:: Main Menu
:MainMenu (
	cls
	:: Change the text to green
	echo [92m

	:: Display Main Manu
	echo.
	echo What would you like to do?
	echo.
	echo 1 - Update Rust Oxide
	echo 2 - Update Rust Edit DLL File
	echo 3 - Update Discord DLL File
	echo 4 - Update Rust Server and SteamCMD
	echo 5 - Backup Entire Server
	echo 6 - Backup Plugins and Configurations
	echo 7 - Wipe Map
	echo 8 - Wipe Blueprints
	echo 9 - Reinstall Entire Server (WARNING: This wipes ALL data relating to your server)
	echo q - Quit
	echo.
	choice /C:123456789q /M "What would you like to do?"

	:: Clear The Text Color
	echo [0m

	:: Update Rust Oxide
	if !ERRORLEVEL! ==1 (
		call modules/Directories.cmd CreateDirectories
		call modules/Oxide.cmd HandleOxide
		call modules/Directories.cmd RemoveTempDirectory
		call :MainMenu
	)

	:: Update Rust Edit DLL File
	if !ERRORLEVEL! ==2 (
		call modules/Directories.cmd CreateDirectories
		call modules/RustEdit.cmd HandleRustEdit
		call modules/Directories.cmd RemoveTempDirectory
		call :MainMenu
	)

	:: Install Discord DLL Extension
	if !ERRORLEVEL! ==3 (
		call modules/Directories.cmd CreateDirectories
		call modules/Discord.cmd HandleDiscord
		call modules/Directories.cmd RemoveTempDirectory
		call :MainMenu
	)

	:: Update Rust Server
	if !ERRORLEVEL! ==4 (
		call modules/Steam.cmd UpdateSteamCMD
		call :MainMenu
	)

	:: Backup Server
	if !ERRORLEVEL! ==5 (
		call modules/Directories.cmd BackupEntireServer
		call :MainMenu
	)

	:: Backup Plugins and Configurations
	if !ERRORLEVEL! ==6 (
		call modules/Directories.cmd BackupPluginsAndConfigurations
		call :MainMenu
	)

	:: Wipe Map
	if !ERRORLEVEL! ==7 (
		call modules/Directories.cmd WipeMap
		call :MainMenu
	)

	:: Wipe Blueprints
	if !ERRORLEVEL! ==8 (
		call modules/Directories.cmd WipeBlueprints
		call :MainMenu
	)

	:: Reinstall Entire Server
	if !ERRORLEVEL! ==9 (
		call modules/Directories.cmd BackupEntireServer
		call modules/Steam.cmd ReinstallRust
		call :MainMenu
	)

	:: Quit
	if !ERRORLEVEL! ==10 goto:eof
)

:: Check for the first run of the script
:CheckForFirstRun (

	:: If the RustServer AND Steam directories does not exist
	if not exist RustServer\ if not exist Steam\ (
		choice /C:yn /t 3 /D y /N /M "First Run has been detected. Would you like to continue with the installation process? (Y/N)"
		if !ERRORLEVEL! ==1 goto :FirstInstall
		if !ERRORLEVEL! ==2 (
			call modules/FlashMessage.cmd alert "You must run the installation process before continuing. Aborting Script!"
			goto:eof
		)
	)

	exit /B %ERRORLEVEL%
)

:: Run the installer for the first time
:FirstInstall (
	:: Create All Working Directories
	call modules/Directories.cmd CreateDirectories

	:: Install & Run SteamCMD
	call modules/Steam.cmd HandleSteamInstall

	:: Install Oxide for Rust
	call modules/Oxide.cmd HandleOxide

	:: Install RustEdit DLL File
	call modules/RustEdit.cmd HandleRustEdit

	:: Install Discord DLL Extension
	call modules/Discord.cmd HandleDiscord

	:: Start Server
	call modules/RustServer.cmd FirstStart

	:: Clean Up Directories
	call modules/Directories.cmd RemoveTempDirectory

	goto:eof
)

:: Exit Out of File
:exit (
	ENDLOCAL
	exit /B %ERRORLEVEL%
)