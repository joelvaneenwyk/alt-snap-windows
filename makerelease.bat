@echo off
setlocal
cd /d "%~dp0"
if !%VERSION% == ! goto FAIL

taskkill /IM AltSnap.exe 2> nul

if exist "%~dp0AltSnap%version%bin_x64.zip" del "%~dp0AltSnap%version%bin_x64.zip"
if exist "%~dp0AltSnap%version%bin.zip" del "%~dp0AltSnap%version%bin.zip"
if exist "%~dp0AltSnap%version%src.zip" del "%~dp0AltSnap%version%src.zip"
if exist "%~dp0AltSnap%version%bin.zip" del "%~dp0AltSnap%version%bin.zip"
if exist "%~dp0AltSnap%version%-x64-inst.exe" del "%~dp0AltSnap%version%-x64-inst.exe"

make -fMakefileX64 clean
make -fMakefileX64
call "%~dp0nsi.bat"
rename "%~dp0AltSnap%VERSION%-inst.exe" "%~dp0AltSnap%VERSION%-x64-inst.exe"

call "%~dp0ziprelease.bat"
rename "%~dp0AltSnap_bin.zip" "%~dp0AltSnap%version%bin_x64.zip"

make clean
make
call "%~dp0nsi.bat"

rhash --sha256 "%~dp0AltSnap%VERSION%-x64-inst.exe" > SHA256.TXT
rhash --sha256 "%~dp0AltSnap%VERSION%-inst.exe" >> SHA256.TXT

call "%~dp0ziprelease.bat"
rename "%~dp0AltSnap_bin.zip" "%~dp0AltSnap%version%bin.zip"

call "%~dp0zzip.bat"
rename "%~dp0AltSnap_src.zip" "%~dp0AltSnap%version%src.zip"

@GOTO END
:FAIL
@echo Error set the VERSION env variable!

:END
