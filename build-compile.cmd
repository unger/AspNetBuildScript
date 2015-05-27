
set MsBuildLogFile=%BuildOutDir%\msbuild_%BuildIdentifier%.log

cmd /c "cd /d %SolutionRootPath% && %NuGetPath% restore"
if %ERRORLEVEL% NEQ 0 (
	pause
	exit /b
)


cmd /c "cd /d %SolutionRootPath% && %MSBuildCustomPath% %SolutionName% /t:Rebuild /fl /flp:logfile=%MsBuildLogFile% /p:Configuration=%BuildConfig%;OutDir="%BuildTempDir%";UseWPP_CopyWebApplication=True;PipelineDependsOnBuild=False"
if %ERRORLEVEL% NEQ 0 (
	pause
	exit /b
)

:: Check for conflicting assemblies
find "This reference is not ""CopyLocal"" because it conflicted with another reference with the same name and lost the conflict" "%MsBuildLogFile%"
if %ERRORLEVEL% == 0 (
	echo Found conflicting versions of the same DLL, please see the file "%MsBuildLogFile%" for more info
	pause
	exit /b
)
