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
			echo.
		)

	ENDLOCAL
	exit /B %ERRORLEVEL%
)