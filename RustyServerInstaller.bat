@echo off

:: Set the window title
Title Rusty Server Installation - By DJRedNight

::::::::::::::::::::
:: Main Functions ::
::::::::::::::::::::

:: Main Script Function
:Main
	:: Display Title Screen
	call modules/Title.cmd TitleScreen
	:: Bring Up The Menu
	call modules/Menu.cmd InvokeMenu
	:: Complete Script
	call :CompleteScript
	exit /B %ERRORLEVEL%

:: Complete Script
:CompleteScript
	cls
	call modules/FlashMessage.cmd success "Script Complete!"
	pause
	exit