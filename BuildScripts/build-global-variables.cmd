:: Set build configuration
set BuildConfig=%1
if "%BuildConfig%" == "" (
	set BuildConfig=Release
)

for /f "tokens=1-3 delims=-" %%a in ("%DATE%") do (set cdate=%%a%%b%%c)
for /f "tokens=1-2 delims=/: " %%a in ("%TIME%") do (set ctime=0%%a%%b)
set ctime=%ctime:~-4%

set DateTime=%cdate%_%ctime%

set BuildIdentifier=%DateTime%

if not defined MSBuildCustomPath (
	set MSBuildCustomPath="%ProgramFiles(x86)%\MSBuild\12.0\Bin\MSBuild.exe"
)

if not defined NuGetPath (
	set NuGetPath=NuGet.exe
)

if not defined SolutionRootPath (
	set SolutionRootPath=%cd%
)

if not defined BuildRootDir (
	set BuildRootDir=%SolutionRootPath%\Build
)


set BuildTempDir=%BuildRootDir%\Temp
set BuildOutDir=%BuildRootDir%\%BuildConfig%

if not exist "%BuildOutDir%/" (
	mkdir %BuildOutDir%
)

set WebProjectOutputFolder=%BuildTempDir%\_PublishedWebsites\%WebProjectName%


