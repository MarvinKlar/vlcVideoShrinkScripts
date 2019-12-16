@echo off

echo Drop the folder you want to convert here...
set /p folder=

setlocal enabledelayedexpansion
set folder=!folder:"=%!

echo Please specify the file extension to convert...
set /p extension=

set extension=!extension:.=%!

echo Converting files

set "progFolder=Program Files"
if exist "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" (
	set "progFolder=Program Files (x86)"
)

for %%a in ("%folder%\*.%extension%") do (
	echo Converting file %%a
	"C:\%progFolder%\VideoLAN\VLC\vlc.exe" -I dummy -v "%%a" --sout=#transcode{vcodec=h264,acodec=mp3}:standard{access=file,mux=mp4,dst="%%a.converted"} vlc://quit
	
	if exist "%%a.converted" (
		echo Deleting old file %%a...
		del "%%a"
	)
	
	FOR %%i IN ("%%a") DO (
		set filename=%%~ni%%~xi
	)
	set file=%%a
	
	if exist "!file!.converted" (
		echo Renaming converted file !file!.converted to !filename!...
		ren "!file!.converted" "!filename!"
	)
)

echo Done

pause
	