@echo off

echo Drop the file you want to convert here...
set /p file=

setlocal enabledelayedexpansion
set file=!file:"=%!

SETLOCAL
FOR %%i IN ("%file%") DO (
	set filename=%%~ni%%~xi
)

set "progFolder=Program Files"
if exist "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" (
	set "progFolder=Program Files (x86)"
)

echo Converting file %file%...
"C:\%progFolder%\VideoLAN\VLC\vlc.exe" -I dummy -v "%file%" --sout=#transcode{vcodec=h264,acodec=mp3}:standard{access=file,mux=mp4,dst="%file%.converted"} vlc://quit

if exist "%file%.converted" (
	echo Deleting old file %file%...
	del "%file%"
)

if exist "%file%.converted" (
	echo Renaming converted file %file%.converted to %filename%...
	ren "%file%.converted" "%filename%"
)

echo Done

pause