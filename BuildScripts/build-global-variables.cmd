:: Set build configuration
set BuildConfig=%1
if "%BuildConfig%" == "" (
	set BuildConfig=Release
)


set DateTime=
Call:GetDateTime DateTime

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


for /f "delims=" %%x in ('dir /ad /od /b %BuildOutDir%') do set LastBuildFullOutDir=%BuildOutDir%\%%x


set WebProjectOutputFolder=%BuildTempDir%\_PublishedWebsites\%WebProjectName%

goto:eof


:GetDateTime       -- function description here
::                 -- %~1: return into variable
SETLOCAL
REM.--function body here

for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%_%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

(ENDLOCAL & REM -- RETURN VALUES
    IF "%~1" NEQ "" SET %~1=%ldt%
)
goto:eof


