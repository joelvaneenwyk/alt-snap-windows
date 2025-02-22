@echo off
setlocal
    call "%~dp0env.bat"
    taskkill /IM AltSnap.exe 2> nul
    taskkill /IM AltSnap.exe 2> nul

    make "%~1"

    if !%~1 == !clean goto:FINISH
    if not exist "%~dp0AltSnap.exe" goto:FINISH
    start "%~dp0AltSnap.exe"
:FINISH
