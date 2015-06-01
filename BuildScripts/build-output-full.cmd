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

set buildFullOutDir=%targetDir%\Full\%buildID%

if exist %buildFullOutDir% (

	echo %buildFullOutDir% already exists
	exit /b
	
)
else (

	if not "%sourceDir%" == "" (

		robocopy %sourceDir% %buildFullOutDir%\Site /MIR /R:5 /W:1 /FFT

		:: Zip full output folder
		powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%buildFullOutDir%', '%targetDir%\%buildID%_full.zip'); }"
	)
)


endlocal
