for /f "tokens=1-3 delims=-" %%a in ("%DATE%") do (set cdate=%%a%%b%%c)
for /f "tokens=1-2 delims=/: " %%a in ("%TIME%") do (set ctime=0%%a%%b)
set ctime=%ctime:~-4%

set DateTime=%cdate%_%ctime%

if not defined MSBuildCustomPath (
	set MSBuildCustomPath=MSBuild.exe
)

if not defined NuGetPath (
	set NuGetPath=NuGet.exe
)

