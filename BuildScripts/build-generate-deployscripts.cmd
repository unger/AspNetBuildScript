@echo off

setlocal EnableDelayedExpansion

set targetDir=%1
if not defined targetDir (
	echo No targetDir defined
	exit /b
)


set DeployDestinationFolder=!DeployDestinationFolder%BuildConfig%!
set DeployVariablesFile=%targetDir%\_deploy-variables.cmd

if not "!DeployDestinationFolder!" == "" (

	copy "%BuildScriptsPath%\compare-folders.cmd" "%targetDir%\compare-folders.cmd" 
	
	echo set DeployDestinationFolder=!DeployDestinationFolder!> %DeployVariablesFile%
	echo set DeployPurgeFolders=%DeployPurgeFolders%>> %DeployVariablesFile%
)

endlocal