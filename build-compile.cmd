
cmd /c "cd /d %SolutionRootPath% && %NuGetPath% restore"
if %ERRORLEVEL% NEQ 0 exit /b

cmd /c "cd /d %SolutionRootPath% && %MSBuildCustomPath% %SolutionName% /t:Rebuild /p:Configuration=%BuildConfig%;OutDir="%BuildTempDir%";UseWPP_CopyWebApplication=True;PipelineDependsOnBuild=False"
if %ERRORLEVEL% NEQ 0 exit /b
