set GitTemp=%BuildRootDir%\GitTemp


if defined GitRemoteRepo (

	echo Clone with git
	
	rd %GitTemp% /s /q

	git clone %GitRemoteRepo% %GitTemp%
	
	set SolutionRootPath=%GitTemp%
	
	for /f %%i in ('git rev-parse --verify HEAD') do set BuildIdentifier=%DateTime%_%%i
)

