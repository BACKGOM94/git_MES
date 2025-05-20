echo off

set INPUT=%1
set UBISERVICE_DIR=C:\webapps\myapp\UbiService
set BATPATH=%UBISERVICE_DIR%\bin\ubiservice.bat
set NSSM=%UBISERVICE_DIR%\bin\nssm64.exe

if "%INPUT%" == "" (

	echo ----------------------------------------
	echo  ex : svcregist.bat [install] [uninstall]
	echo ----------------------------------------
	echo.
) else (

	if "%INPUT%" == "install" (

		echo ----------------------------------------
		echo       UbiService Registration Job
		echo ----------------------------------------
		echo.

		echo [UbiService Regist]
		%NSSM% install UbiService %BATPATH%
		echo.

		echo [UbiService Set Description]
		%NSSM% set UbiService Description "UbiService for UbiReport4.0"
		echo.

		echo [UbiService Start]
		%NSSM% start UbiService
		echo.
		echo ----------------------------------------
		echo              Install Completed
		echo ----------------------------------------
		echo.
	) else (

		if "%INPUT%" == "uninstall" (

			echo ----------------------------------------
			echo      UbiService UnRegistration Job
			echo ----------------------------------------
			echo.

			echo [UbiService Stop]
			%NSSM% stop UbiService
			echo.

			echo [UbiService Unregist]
			%NSSM% remove UbiService confirm
			echo.

			echo ----------------------------------------
			echo               Uninstall Completed
			echo ----------------------------------------
			echo.
		) else (

			echo ----------------------------------------
			echo  ex : svcregist.bat [install] [uninstall]
			echo ----------------------------------------
			echo.
		)
	)
)

