@echo Off
setlocal

:: Import custom variables
call build-custom-variables.cmd


:: Import variables
call build-variables.cmd %1


:: Pull from Git
call build-git-clone.cmd
if %ERRORLEVEL% NEQ 0 exit /b


:: Compile solution
call build-compile %SolutionRootPath% %BuildTempDir%


:: Configuration transform
call build-configuration-transform %SolutionRootPath%/%WebProjectName% %WebProjectOutputFolder%


:: Create differential output
::call build-output-differential %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%


:: Create full output
::call build-output-full %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%

endlocal
