@echo off

setlocal EnableDelayedExpansion

set DestPath=%1
if not defined DestPath (
	echo No DestPath defined
	exit /b
)



set LogFile=%cd%\deploy-log.txt
set DeployFile=%cd%\deploy.cmd

echo Compare with %DestPath% > %LogFile%
echo :Compare with %DestPath% > %DeployFile%

cd Site
for /r %%f in (*.*) do (
	set sourceFile=%%f
	set sourceFile=!sourceFile:%cd%=!
	if "!sourceFile:~0,1!"=="\" SET sourceFile=!sourceFile:~1!
	echo !sourceFile!
	
	ECHO n | comp !sourceFile! %DestPath%\!sourceFile!
	
	if !ErrorLevel!==1 (
		echo Update: !sourceFile! >> %LogFile%
		echo xcopy Site\!sourceFile! %DestPath%\!sourceFile! /Y >> %DeployFile%
	)
	
	if !ErrorLevel!==2 (
		echo New file: !sourceFile! >> %LogFile%
		echo Echo f ^| xcopy "Site\!sourceFile!" "%DestPath%\!sourceFile!" /Y >> %DeployFile%
	)
	
)
cd ..

endlocal