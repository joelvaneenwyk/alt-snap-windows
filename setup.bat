@echo off
goto:$Main

:Scoop
    echo ##[cmd] scoop %*
    call scoop %*
exit /b %ERRORLEVEL%

:$Main
setlocal EnableExtensions
    call pwsh -NoProfile -Command "iwr -useb get.scoop.sh | iex"
    call npm install -g makensis

    :: https://www.mingw-w64.org/downloads/#mingw-builds
    call :Scoop bucket add "main"
    call :Scoop install --no-update-scoop "main/mingw"
    call :Scoop install --no-update-scoop "main/mingw-winlibs"
    call :Scoop install --no-update-scoop "main/rhash"
    call :Scoop install --no-update-scoop "main/7zip"
    call :Scoop install --no-update-scoop "main/tcc"
    call :Scoop install --no-update-scoop "main/ninja"
    call :Scoop install --no-update-scoop "main/msys2"

    call :Scoop bucket add "versions"
    call :Scoop install --no-update-scoop "versions/mingw-winlibs-ucrt"
    call :Scoop install --no-update-scoop "versions/mingw-winlibs-ucrt-mcf"
    call :Scoop install --no-update-scoop "versions/mingw-winlibs-llvm"
    call :Scoop install --no-update-scoop "versions/mingw-winlibs-llvm-ucrt"
    call :Scoop install --no-update-scoop "versions/mingw-winlibs-llvm-ucrt-mcf"

    call :Scoop update *
endlocal & goto:EOF
