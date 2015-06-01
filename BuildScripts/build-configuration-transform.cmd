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


echo %sourceDir%
echo %targetDir%


packages\WebConfigTransformRunner.1.0.0.1\Tools\WebConfigTransformRunner.exe %sourceDir%\Web.Config %sourceDir%\Web.%BuildConfig%.Config %targetDir%\Web.Config.%BuildConfig%Transformed



endlocal
