@echo Off

setlocal

:: Import variables
call build-variables.cmd

:: Try to find solution
set solutionName=
for %%i in (*.sln) do set solutionName=%%i

if "%solutionName%" == "" (
	Echo No Solution file found in folder
	Exit /b
)

:: Set build configuration
set config=%1
if "%config%" == "" (
	set config=Release
)


set buildTempDir=Build\Temp
set buildOutDir=Build\%config%


%NuGetPath% restore
if %ERRORLEVEL% NEQ 0 exit /b

%MSBuildCustomPath% %solutionName% /t:Rebuild /p:Configuration=%config%;OutDir="%cd%\%buildTempDir%";UseWPP_CopyWebApplication=True;PipelineDependsOnBuild=False
if %ERRORLEVEL% NEQ 0 exit /b

set webProjectOutputFolder=
for /d %%i in (%buildTempDir%\_PublishedWebsites\*) do set webProjectOutputFolder=%%i


:: Create differential output
call build-output-differential %webProjectOutputFolder% %buildOutDir% %DateTime%

:: Create full output
call build-output-full %webProjectOutputFolder% %buildOutDir% %DateTime%

endlocal
