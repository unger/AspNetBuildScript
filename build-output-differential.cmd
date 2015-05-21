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

set buildDiffOutDir=%targetDir%\Differential\%buildID%

set buildLastFullDir=
for /d %%i in (%targetDir%\Full\*) do set buildLastFullDir=%%i

if not "%sourceDir%" == "" (

	if not "%buildLastFullDir%" == "" (
		robocopy %buildLastFullDir%\Site %buildDiffOutDir%\Temp /MIR /A-:A /R:5 /W:1 /FFT
		robocopy %sourceDir% %buildDiffOutDir%\Temp /S /XO /A+:A /R:5 /W:1 /FFT
		robocopy %buildDiffOutDir%\Temp %buildDiffOutDir%\Site /S /A /R:5 /W:1 /FFT
		rmdir %buildDiffOutDir%\Temp /s /q

		:: Zip differential output folder
		powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%buildDiffOutDir%', '%targetDir%\%buildID%_differential.zip'); }"
	)
)

endlocal
