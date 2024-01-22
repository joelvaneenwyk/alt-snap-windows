@echo off
setlocal EnableExtensions

setlocal
cd /d "%~dp0"
call "%~dp0env.bat"
taskkill /IM AltSnap.exe 2> nul
taskkill /IM AltSnap.exe 2> nul

if !%1 == !db GOTO:DEBUG

call make -fMakefileX64 "clean"
call make -fMakefileX64 "%~1"

if !%1 == !clean GOTO:FINISH
if exist "%~dp0AltSnap.exe" start "%~dp0AltSnap.exe"
GOTO:FINISH

:DEBUG
echo x86_64b Debug build
call make -fMakefileX64db
if exist "%~dp0AltSnap.exe" gdb.exe "%~dp0AltSnap.exe"

:FINISH
