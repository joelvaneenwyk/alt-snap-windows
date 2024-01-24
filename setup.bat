@echo off
goto:$Main

:Scoop
    echo ##[cmd] scoop %*
    call scoop %*
exit /b %ERRORLEVEL%

:$Main
    setlocal EnableExtensions

    :: https://www.mingw-w64.org/downloads/#mingw-builds
    call :Scoop bucket add "main"
    call :Scoop install "main/mingw"
    call :Scoop install "main/mingw-winlibs"
    call :Scoop install "main/rhash"
    call :Scoop install "main/7zip"
    call :Scoop install "main/tcc"
    call :Scoop install "main/ninja"
    call :Scoop install "main/msys2"

    call :Scoop bucket add "versions"
    call :Scoop install "versions/mingw-winlibs-ucrt"
    call :Scoop install "versions/mingw-winlibs-ucrt-mcf"
    call :Scoop install "versions/mingw-winlibs-llvm"
    call :Scoop install "versions/mingw-winlibs-llvm-ucrt"
    call :Scoop install "versions/mingw-winlibs-llvm-ucrt-mcf"

    call :Scoop update *
endlocal & goto:EOF
