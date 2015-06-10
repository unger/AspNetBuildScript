@echo Off
setlocal

set BuildScriptsPath=BuildScripts

:: Import variables
call build-variables.cmd


:: Import variables
call "%BuildScriptsPath%\build-global-variables.cmd" %1


:: Pull from Git
call "%BuildScriptsPath%\build-git-clone.cmd"


:: Compile solution
call "%BuildScriptsPath%\build-compile.cmd" %SolutionRootPath% %BuildTempDir%


:: Configuration transform
call "%BuildScriptsPath%\build-configuration-transform.cmd" %SolutionRootPath%/%WebProjectName% %WebProjectOutputFolder%


:: Minify HTML
call "%BuildScriptsPath%\bin\HtmlMinifier.exe" "%WebProjectOutputFolder%"


:: Create output
call "%BuildScriptsPath%\build-output.cmd" %WebProjectOutputFolder% %BuildOutDir% %BuildIdentifier%


:: Generate deploy scripts
call "%BuildScriptsPath%\build-generate-deployscripts.cmd" %BuildOutDir%\%BuildIdentifier%


:: Zip output folder
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%BuildOutDir%\%BuildIdentifier%', '%BuildOutDir%\%BuildConfig%_%BuildIdentifier%.zip'); }"


:: Generate changes since last build
call "%BuildScriptsPath%\build-generate-changes-since-lastbuild.cmd"


pause

endlocal
