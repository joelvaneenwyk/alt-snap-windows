@echo off
setlocal
cd /d "%~dp0"
7z a -tzip ^
    AltSnap_bin.zip AltSnap.txt AltSnap.exe ^
    hooks.dll AltSnap.ini AltSnap.xml ^
    LICENSE languages\*
