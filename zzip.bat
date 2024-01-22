@echo off
setlocal
cd /d "%~dp0"
7z a -tzip ^AltSnap_src.zip AltSnap.txt AltSnap.ini AltSnap.xml altsnap.nsi License.txt altsnap.c altsnap.rc config.c hooks.c hooks.rc languages.c languages.h resource.h tray.c hooks.h unfuck.h nanolibc.h window.rc AltSnap.exe.manifest makefile media\* Lang\*
