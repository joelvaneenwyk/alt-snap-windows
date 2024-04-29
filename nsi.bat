@echo off
setlocal
cd /d "%~dp0"
"%PROGRAMFILES%\nsis-2.51\makensis.exe" /V2 AltSnap.nsi
