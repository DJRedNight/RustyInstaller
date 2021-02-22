@echo off
call:%~1
goto exit

:: Start Rust Server
:FirstStart
	cls
	echo [92m
	echo Starting Your Rust Server. This process is needed to finalize installation of Oxide and RustEdit. Once the server is up and running, you may close the new window that opens or use the quit command to stop your server and come back to this screen. Once you see that bradley has spawned in, you can close out of your Rust server. From now on, you will use the StartServer.cmd file in order to start up your server.
	echo.
	echo To make any changes to your configuration files, backup your server, wipe your map or blueprints, re-run the RustyServerInstaller.bat file again, and choose an option from the menu.
	echo.
	echo If you want to change any of your server parameters such as map seed, map size, amount of players, port numbers, etc. you can edit the proceduralConfig.json file or the customMapConfig.json file using Notepad, Sublime Text, Atom, or your code editor of your choosing.
	echo.
	echo Once you press any key to continue you will have two windows open, the menu and your Rust Server.
	echo [0m
	pause
	START "RustServer" StartServer.cmd
	goto:eof

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%