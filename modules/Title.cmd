@echo off
call:%~1
goto exit

:: Title Screen
:TitleScreen
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
	echo # https://github.com/DJRedNight/RustyInstaller       #
	echo #                                                    #
	echo #              AGPL-v3 - Copyright 2021              #
	echo #                All Rights Reserved                 #
	echo ######################################################

	:: Clear The Text Color
	echo [0m

	:: Pause and wait for the user to continue
	pause
	cls
	goto:eof

:: Exit Out of File
:exit
	exit /B %ERRORLEVEL%