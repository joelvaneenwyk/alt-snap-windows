@echo off
setlocal EnableDelayedExpansion

:: https://www.mingw-w64.org/downloads/#mingw-builds
call scoop install "main/mingw"
call scoop install "main/mingw-winlibs"
call scoop install "main/rhash"
call scoop install "main/7zip"
