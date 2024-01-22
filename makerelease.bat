@echo off
setlocal EnableExtensions

if !%VERSION% == ! goto FAIL

taskkill /IM AltSnap.exe 2> nul

set "_root=%~dp0"

del "%_root%\AltSnap%version%bin_x64.zip"
del "%_root%\AltSnap%version%bin.zip"
del "%_root%\AltSnap%version%src.zip"
del "%_root%\AltSnap%version%bin.zip"
del "%_root%\AltSnap%version%-x64-inst.exe"

make -f"%_root%\MakefileX64" clean
make -f"%_root%\MakefileX64"
call "%_root%\nsi.bat"
rename "%_root%\AltSnap%VERSION%-inst.exe" "%_root%\AltSnap%VERSION%-x64-inst.exe"

call "%~dp0ziprelease.bat"
rename "%_root%\AltSnap_bin.zip" "%_root%\AltSnap%version%bin_x64.zip"

make clean
make
call "%_root%\nsi.bat"

rhash --sha256 "%_root%\AltSnap%VERSION%-x64-inst.exe" > "%_root%\SHA256.TXT"
rhash --sha256 "%_root%\AltSnap%VERSION%-inst.exe" >> "%_root%\SHA256.TXT"

call "%_root%\ziprelease.bat" "%_root%\
rename "%_root%\AltSnap_bin.zip" "%_root%\AltSnap%version%bin.zip"

call "%_root%\zzip.bat"
rename "%_root%\AltSnap_src.zip" "%_root%\AltSnap%version%src.zip"

@GOTO END
:FAIL
@echo Error set the VERSION env variable!

:END
