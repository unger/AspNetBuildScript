@echo Off

setlocal

set sourceDir=%1
if not defined sourceDir (
	echo No sourceDir defined
	exit /b
)
set targetDir=%2
if not defined targetDir (
	echo No targetDir defined
	exit /b
)
set buildID=%3
if not defined buildID (
	echo No buildID defined
	exit /b
)

set buildFullOutDir=%targetDir%\%buildID%

if exist %buildFullOutDir% (

	echo %buildFullOutDir% already exists
	exit /b
	
) else (

	if not "%sourceDir%" == "" (

		echo Copy from "%sourceDir%" to "%buildFullOutDir%"
		robocopy %sourceDir% %buildFullOutDir%\Site /MIR /NP /NJS /NJH /NDL /NFL /NC /R:5 /W:1 /FFT		

	)
)


endlocal
