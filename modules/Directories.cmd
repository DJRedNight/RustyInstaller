@echo off
call:%~1
goto exit

:: Create All Working Directories
:CreateDirectories
	call :MakeTempDirectory
	call :CreateRustServerDirectory
	call :CreateSteamDirectory
	goto:eof

:: Remove Temp Directory
:RemoveTempDirectory
	echo Cleaning Up...
	if exist temp\ rmdir /S /Q temp
	call modules/FlashMessage.cmd success "Clean Up Complete!"
	goto:eof

:: Remove Rust Server Directory
:RemoveRustServerDirectory
	if exist RustServer\ (
		echo Removing RustServer Directory...
		rmdir /S /Q RustServer
		call modules/FlashMessage.cmd success "Removed RustServer Directory Successfully!"
	)
	goto:eof

:: Backup Plugins And Configurations
:BackupPluginsAndConfigurations
	:: Create the Directories to store the backups in
	call :CreateBackupDirectory
	call :CreateBackupDateDirectory BACKUPDIR
	set BACKUPDIR=%cd%\%BACKUPDIR%

	:: Copy the Relevent Folders and Files
	echo Copying the oxide folder to the backup directory...
	xcopy /y /e /h /q %cd%\RustServer\oxide %BACKUPDIR%
	call modules/FlashMessage.cmd success "Oxide folder was copied successfully!"
	timeout /t 5
	goto:eof

:: Wipe Blueprints
:WipeBlueprints
	:: Create the Directories to store the backups in
	call :CreateBackupDirectory
	call :CreateBackupDateDirectory BACKUPDIR
	set BACKUPDIR=%cd%\%BACKUPDIR%

	echo Backing up the blueprint file just in case...
	move /y RustServer\server\myserver\player.blueprints.*.* %BACKUPDIR%
	call modules/FlashMessage.cmd success "Moved blueprints file successfully!"

	call modules/FlashMessage.cmd success "Blueprint Data Has Been Wiped Successfully!"
	timeout /t 5
	goto:eof

:: Wipe Map Files
:WipeMap
	:: Create the Directories to store the backups in
	call :CreateBackupDirectory
	call :CreateBackupDateDirectory BACKUPDIR
	set BACKUPDIR=%cd%\%BACKUPDIR%

	echo Backing up the map files just in case...
	for /f %%a in ('dir RustServer\server\myserver /a:-D /b') do (
		echo "%%~a"|findstr /i /L ".map">nul
		if not errorlevel 1 (
			echo Map File Found! Moving to backup directory...
			move /y "RustServer\server\myserver\%%~a" %BACKUPDIR%
		)
		echo "%%~a"|findstr /i /L ".sav">nul
		if not errorlevel 1 (
			echo Map Save File Found! Moving to backup directory...
			move /y "RustServer\server\myserver\%%~a" %BACKUPDIR%
		)	
	)

	call modules/FlashMessage.cmd success "Your Map Files have been backed up and your server maps are now wiped!"
	timeout /t 5
	goto:eof

:: Backup Entire Server
:BackupEntireServer

	:: Create the Directories to store the backups in
	call :CreateBackupDirectory
	call :CreateBackupDateDirectory BACKUPDIR
	set BACKUPDIR=%cd%\%BACKUPDIR%

	:: Copy relevant folders and files to the backup directory
	echo Copying Files and Folders To Backup Directory...
	echo.
	
	echo Copying Oxide...
	xcopy /y /i /e /h /q %cd%\RustServer\oxide %BACKUPDIR%\oxide

	echo Copying Configuration Files...
	xcopy /y /i /e /h /q %cd%\RustServer\config %BACKUPDIR%\config

	echo Copying Logs...
	xcopy /y /i /e /h /q %cd%\RustServer\logs %BACKUPDIR%\logs

	echo Copying RustDedicated_Data...
	xcopy /y /i /e /h /q %cd%\RustServer\RustDedicated_Data %BACKUPDIR%\RustDedicated_Data

	echo Copying Server Files...
	xcopy /y /i /e /h /q %cd%\RustServer\server %BACKUPDIR%\server

	echo Copying User Data...
	xcopy /y /i /e /h /q %cd%\RustServer\userdata %BACKUPDIR%\userdata

	call modules/FlashMessage.cmd success "Copying Files Complete!"

	echo Creating a zip file of all the data for easier accessibility and storage
	powershell.exe -command "Compress-Archive -Path %BACKUPDIR%\* -DestinationPath %BACKUPDIR%"
	call modules/FlashMessage.cmd success "Zip File Created!"

	echo Removing Date Specific Backup Directory to save space...
	rmdir /S /Q %BACKUPDIR%
	call modules/FlashMessage.cmd success "Removed Date Specific Backup Directory Successfully!"

	call modules/FlashMessage.cmd success "Backup Complete!"

	timeout /t 5
	goto:eof

:: Create Backup Directory
:CreateBackupDirectory
	echo Making a Backup directory to save backups to...
	if not exist Backups\ (
		mkdir Backups
		call modules/FlashMessage.cmd success "Created Backups Directory Successfully!"
	) else (
		call modules/FlashMessage.cmd warning "Backups Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%

:: Create Backup Date Directory
:CreateBackupDateDirectory
	echo Creating a date specific directory inside the Backups directory...
	call :GetUnixTime UNIX_TIME
	set BACKUPDIR=Backups\%UNIX_TIME%
	mkdir %BACKUPDIR%
	call modules/FlashMessage.cmd success "Created Backups Directory Successfully!"
	set "%1=%BACKUPDIR%"
	exit /B %ERRORLEVEL%

:: Make A Temp Directory To Work Out Of
:MakeTempDirectory
	echo Making a temporary directory to work out of...
	if not exist temp\ (
		mkdir temp
		call modules/FlashMessage.cmd success "Created Temp Directory Successfully!"
	) else (
		call modules/FlashMessage.cmd warning "Temp Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%

:: Create Rust Directory Function
:CreateRustServerDirectory
	echo Creating RustServer Directory
	if not exist RustServer\ (
		mkdir RustServer
		call modules/FlashMessage.cmd success "Created RustServer Directory Successfully!"
	) else (
		call modules/FlashMessage.cmd warning "RustServer Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%

:: Create Rust Directory Function
:CreateSteamDirectory
	echo Creating Steam Directory
	if not exist Steam\ (
		mkdir Steam
		call modules/FlashMessage.cmd success "Created Steam Directory Successfully!"
	) else (
		call modules/FlashMessage.cmd warning "Steam Directory Already Exists... Skipping this step."
	)
	exit /B %ERRORLEVEL%

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%

:::::::::::::::::::::::::::
:: Misc Helper Functions ::
:::::::::::::::::::::::::::

:: Get UNIX Timestamp Script
:GetUnixTime
setlocal enableextensions
for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do (
    set %%x)
set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
set /a ut=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
endlocal & set "%1=%ut%" & goto :EOF