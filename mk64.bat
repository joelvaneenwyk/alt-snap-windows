@echo off
setlocal EnableExtensions

@taskkill /IM AltSnap.exe 2> nul
@taskkill /IM AltSnap.exe 2> nul

@if !%~1 == !db GOTO DEBUG

make -f"%~dp0MakefileX64" %~1

@if !%~1 == !clean GOTO FINISH
if exist "%~dp0AltSnap.exe" @start "%~dp0AltSnap.exe"
@GOTO FINISH

: DEBUG
@echo x86_64b Debug build
make -f"%~dp0MakefileX64db"
if exist "%~dp0AltSnap.exe" call gdb.exe"%~dp0AltSnap.exe"

:FINISH
