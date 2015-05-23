@echo Off
setlocal

:: Import variables
call build-variables.cmd %1

:: Import custom variables
call build-custom-variables.cmd

:: Pull from Git
call build-git-clone.cmd
if %ERRORLEVEL% NEQ 0 exit /b


:: Compile solution
call build-compile %SolutionRootPath% %BuildTempDir%


set WebProjectOutputFolder=
for /d %%i in (%BuildTempDir%\_PublishedWebsites\*) do set WebProjectOutputFolder=%%i


:: Create differential output
call build-output-differential %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%

:: Create full output
call build-output-full %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%

endlocal
