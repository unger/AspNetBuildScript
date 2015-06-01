@echo Off
setlocal

set BuildScriptsPath=BuildScripts

:: Import variables
call build-variables.cmd


:: Import variables
call %BuildScriptsPath%/build-global-variables.cmd %1


:: Pull from Git
call %BuildScriptsPath%/build-git-clone.cmd


:: Compile solution
call %BuildScriptsPath%/build-compile %SolutionRootPath% %BuildTempDir%


:: Configuration transform
call %BuildScriptsPath%/build-configuration-transform %SolutionRootPath%/%WebProjectName% %WebProjectOutputFolder%


:: Create differential output
call %BuildScriptsPath%/build-output-differential %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%


:: Create full output
call %BuildScriptsPath%/build-output-full %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%

endlocal
