@echo off

setlocal ENABLEEXTENSIONS
setlocal EnableDelayedExpansion

:: Import variables
call _deploy-variables.cmd



set LogFile=%cd%\compare-log.txt
set DeployFile=%cd%\deploy.cmd
set RestoreFile=%cd%\restore.cmd
set DeploySourceFolder=%cd%\Site
set DeployBackupFolder=%cd%\Backup

del "%LogFile%" /Q
del "%DeployFile%" /Q
del "%RestoreFile%" /Q

for /r "%DeploySourceFolder%" %%f in (*.*) do (
	set sourceFile=%%f
	set sourceFile=!sourceFile:%DeploySourceFolder%=!
	if "!sourceFile:~0,1!"=="\" SET sourceFile=!sourceFile:~1!
	echo !sourceFile!
	
	ECHO n | comp "%DeploySourceFolder%\!sourceFile!" "%DeployDestinationFolder%\!sourceFile!"
	
	if !ErrorLevel!==1 (
		echo Update: !sourceFile! >> "%LogFile%"
		echo echo f ^| xcopy "Site\!sourceFile!" "%DeployDestinationFolder%\!sourceFile!" /Y >> "%DeployFile%"
		:: Backup file
		echo f | xcopy "%DeployDestinationFolder%\!sourceFile!" "%DeployBackupFolder%\!sourceFile!" /Y
		echo echo f ^| xcopy "%DeployBackupFolder%\!sourceFile!" "%DeployDestinationFolder%\!sourceFile!" /Y >> "%RestoreFile%"
	)
	
	if !ErrorLevel!==2 (
		echo New file: !sourceFile! >> "%LogFile%"
		echo echo f ^| xcopy "Site\!sourceFile!" "%DeployDestinationFolder%\!sourceFile!" /Y >> "%DeployFile%"
		:: Backup file
		echo del "%DeployDestinationFolder%\!sourceFile!" /Q >> "%RestoreFile%"
	)
)

echo 

for %%a in (%DeployPurgeFolders%) do (
	set folder=%%a
	if exist %DeployDestinationFolder%\!folder! (
		pushd %DeployDestinationFolder%\!folder!
		for /r %%f in (*.*) do (
			set oldfile=%%f
			set oldfile=!oldfile:%DeployDestinationFolder%=!
			if "!oldfile:~0,1!"=="\" SET oldfile=!oldfile:~1!
			
			if not exist "%DeploySourceFolder%\!oldfile!" (
				echo Delete file: !oldfile! >> "%LogFile%"
				echo del "%DeployDestinationFolder%\!oldfile!" /Q >> "%DeployFile%"
				:: Backup file
				echo f | xcopy "%DeployDestinationFolder%\!oldfile!" "%DeployBackupFolder%\!oldfile!" /Y
				echo echo f ^| xcopy "%DeployBackupFolder%\!oldfile!" "%DeployDestinationFolder%\!oldfile!" /Y >> "%RestoreFile%"
			)
		)
		popd
	)
)


endlocal

pause