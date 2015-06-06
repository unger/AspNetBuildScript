@echo off

setlocal ENABLEEXTENSIONS
setlocal EnableDelayedExpansion


set CurrentBuildFolder=%BuildOutDir%\%BuildIdentifier%\Site
set ChangesFolder=%BuildOutDir%\%BuildIdentifier%\Changes


for /r "%CurrentBuildFolder%" %%f in (*.*) do (
	set sourceFile=%%f
	set sourceFile=!sourceFile:%CurrentBuildFolder%=!
	if "!sourceFile:~0,1!"=="\" SET sourceFile=!sourceFile:~1!
	echo !sourceFile!
	
	ECHO n | comp "%CurrentBuildFolder%\!sourceFile!" "%LastBuildFullOutDir%\!sourceFile!"
	
	if !ErrorLevel!==1 (
		echo f | xcopy "%CurrentBuildFolder%\!sourceFile!" "%ChangesFolder%\!sourceFile!" /Y
	)
	
	if !ErrorLevel!==2 (
		echo f | xcopy "%CurrentBuildFolder%\!sourceFile!" "%ChangesFolder%\!sourceFile!" /Y
	)
)



