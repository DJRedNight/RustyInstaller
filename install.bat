@echo off

:: Set the window title
Title "Rusty Server Installation - By DJRedNight"

:: Title Screen
:TitleScreen (
	:: Change the text to green
	echo [92m

	:: Display Title Screen
	echo ######################################################
	echo #                                                    #
	echo #              Rusty Server Installation             #
	echo #                                                    #
	echo #                     Created By                     #
	echo #                     DJRedNight                     #
	echo #                                                    #
	echo ######################################################
	echo #                                                    #
	echo # Read the documentation before using this program!  #
	echo # You can find the documentation on our Github Page. #
	echo #                                                    #
	echo # http://github.com/DJRedNight/whatever              #
	echo #                                                    #
	echo #              AGPL-v3 - Copyright 2021              #
	echo #                All Rights Reserved                 #
	echo ######################################################
	echo [0m

	:: Pause and wait for the user to continue
	pause
	cls
	@goto :Main
)

:::::::::::::::::::::::
:: Primary Functions ::
:::::::::::::::::::::::

:: Main Script Function
:Main (
	:: Make a temp directory
	call :MakeTempDirectory

	:: Download SteamCMD
	call :DownloadSteamCMD

	:: Create RustServer Directory
	call :CreateRustServerDirectory

	:: Run SteamCMD
	call :RunSteamCMD

	:: Install Oxide for Rust
	call :InstallOxide

	:: Install RustEdit DLL File
	call :InstallRustEditDLL

	:: Start Server
	call :StartRustServer

	:: Complete Script
	call :CompleteScript

	exit /B %ERRORLEVEL%
)

:::::::::::::::::::::::::
:: Secondary Functions ::
:::::::::::::::::::::::::

:: Make A Temp Directory To Work Out Of
:MakeTempDirectory (
	echo Making a temporary directory to work out of...
	if not exist temp\ (
		mkdir temp
		call :FlashMessage success "Created Temp Directory Successfully!"
	) else (
		call :FlashMessage warning "Temp Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%
)

:: Download Steam CMD
:DownloadSteamCMD (
	echo "Downloading SteamCMD..."

	if exist %cd%\Steam\steamcmd.exe (
		call :FlashMessage warning "SteamCMD Already Exists. No need to download it again."
		exit /B %ERRORLEVEL%
	)

	:: Grab the latest SteamCMD ZIP File
	echo Grabbing the latest SteamCMD zip file from Valve
	powershell.exe -command "Invoke-WebRequest https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -outfile temp\steamcmd.zip"
	call :FlashMessage success "Grabbed SteamCMD Successfully!"

	:: Create Steam Folder
	echo Creating the Steam Folder
	if not exist Steam\ (mkdir Steam)
	call :FlashMessage success "Created the Steam Folder Successfully!"

	:: Unzip The ZIP file
	echo Unzipping the SteamCMD ZIP File
	powershell.exe Expand-Archive -Force temp\steamcmd.zip -DestinationPath Steam
	call :FlashMessage success "Unzipped the file successfully!"

	call :FlashMessage success "Downloaded SteamCMD Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%
)

:: Create Rust Directory Function
:CreateRustServerDirectory (
	echo Creating RustServer Directory
	if not exist RustServer\ (
		mkdir RustServer
		call :FlashMessage success "Created RustServer Directory Successfully!"
	) else (
		call :FlashMessage warning "RustServer Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%
)

:: Run SteamCMD Function
:RunSteamCMD (
	echo Running SteamCMD and Installing Rust Server Files
	%cd%\Steam\steamcmd.exe ^
	+login anonymous ^
	+force_install_dir %cd%\RustServer ^
	+app_update 258550 ^
	+quit
	call :FlashMessage success "Installed Rust Server Files Successfully!"
	exit /B %ERRORLEVEL%
)

:: Install Oxide for Rust
:InstallOxide (

	:: Grab the latest Oxide For Rust ZIP File
	echo Downloading Latest Oxide for Rust Build...
	powershell.exe -command "Invoke-WebRequest https://github.com/OxideMod/Oxide.Rust/releases/latest/download/Oxide.Rust.zip -outfile temp\oxide.zip"
	call :FlashMessage success "Grabbed Oxide Successfully from Releases!"

	:: Unzip The ZIP file
	echo Unzipping the Oxide for Rust ZIP File
	powershell.exe Expand-Archive -Force temp\oxide.zip -DestinationPath RustServer
	call :FlashMessage success "Unzipped the file successfully!"

	call :FlashMessage success "Downloaded Oxide for Rust Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%
)

:: Install RustEditDLL
:InstallRustEditDLL (

	:: Grab the latest RustEditDLL File
	echo Downloading Latest RustEdit DLL File...
	powershell.exe -command "Invoke-WebRequest https://github.com/k1lly0u/Oxide.Ext.RustEdit/raw/master/Oxide.Ext.RustEdit.dll -outfile RustServer\RustDedicated_Data\Managed\Oxide.Ext.RustEdit.dll"
	call :FlashMessage success "Grabbed RustEditDLL Successfully from Releases!"

	call :FlashMessage success "Downloaded RustEdit DLL Successfully!"
	timeout /t 5

	exit /B %ERRORLEVEL%

)

:: Start Rust Server
:StartRustServer (

	cls
	echo [92m
	echo Starting Your Rust Server. This process is needed to finalize installation of Oxide and RustEdit. Once the server is up and running, you may close the new window that opens and come back to this screen.
	echo.
	echo Once you see that Bradley has spawned in, you can go ahead and close out the window. From now on, you will use the StartServer.cmd file in order to start up your server. If you want to update your server with the latest Oxide or RustEdit.dll Files, you can rerun the install.bat file.
	echo.
	echo If you want to change any of your server parameters such as map seed, map size, amount of players, port numbers, etc. you can edit the StartServer.cmd file using Notepad, Sublime Text, Atom, or your code editor of your choosing. Make sure to leave the VERY FIRST LINE alone. Do not edit that line.
	echo [0m
	pause

	START "RustServer" StartServer.cmd

	exit /B %ERRORLEVEL%

)

:::::::::::::::::::::::::::
:: Misc Helper Functions ::
:::::::::::::::::::::::::::

:: Complete Script
:CompleteScript (
	cls
	rmdir /S /Q temp
	call :FlashMessage success "Script Complete!"
	pause
	exit
)

:: Message Handler
:FlashMessage type,message (
	SETLOCAL

		set type=%1
		set message=%~2

		:: Success Message
		if %type% == success (
			echo [92m%message%[0m
		)

		:: Error Message
		if %type% == error (
			echo [91m%message%[0m
		)

		:: Warning Message
		if %type% == warning (
			echo [93m%message%[0m
		)

		:: Alert Message
		if %type% == alert (
			echo.
			echo [91m###########################################################################
			echo # ALERT: %message%
			echo ###########################################################################[0m
			pause
			echo.
		)

	ENDLOCAL
	exit /B %ERRORLEVEL%
)






