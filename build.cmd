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


:: Create output
call %BuildScriptsPath%/build-output %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%

:: Generate deploy scripts
call %BuildScriptsPath%/build-generate-deployscripts %BuildOutDir%\%BuildIdentifier%


:: Zip output folder
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%BuildOutDir%\%BuildIdentifier%', '%BuildOutDir%\%BuildConfig%_%BuildIdentifier%.zip'); }"

pause

endlocal
