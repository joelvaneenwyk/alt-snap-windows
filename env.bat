@echo off
goto:$Main

:SetPathEnvironment
setlocal EnableDelayedExpansion
    set "_root=%~dp0"
    set "_mingw_root=%USERPROFILE%\scoop\apps\mingw\current"

    set "_path=C:\Program Files\PowerShell\7;C:\Windows\System32;C:\Windows;C:\Windows\System32\wbem"
    set "_path=!_path!;C:\Windows\System32\WindowsPowerShell\v1.0"
    set "_path=!_path!;%_mingw_root%\bin;%_mingw_root%\lib"
    set "_path=!_path!;%USERPROFILE%\.dotfiles;%USERPROFILE%\.dotfiles\source\windows\bin"
    set "_path=!_path!;C:\Program Files (x86)\GnuPG\bin;C:\Program Files (x86)\Gpg4win\bin;C:\Program Files\Git\bin"
    set "_path=!_path!;C:\Program Files\dotnet"
    set "_path=!_path!;C:\Program Files\gsudo\Current"
    set "_path=!_path!;C:\Program Files\nodejs"
    set "_path=!_path!;C:\Program Files\GitHub CLI"
    set "_path=!_path!;C:\Program Files\Git\cmd"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Microsoft\WindowsApps"
    set "_path=!_path!;%USERPROFILE%\AppData\Roaming\npm"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Programs\Microsoft VS Code\bin"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Programs\Python\Launcher"
    set "_path=!_path!;%USERPROFILE%\.cargo\bin"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Programs\Python\Python311\Scripts"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Programs\Python\Python311"
    set "_path=!_path!;C:\Program Files (x86)\GnuWin32\bin"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\GitHubDesktop\bin"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\Microsoft\WinGet\Links"
    set "_path=!_path!;%USERPROFILE%\scoop\apps\gsudo\current"
    set "_path=!_path!;%USERPROFILE%\AppData\Local\JetBrains\Toolbox\scripts"

    set "_path=!_path!;C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64"
    set "_dev_cmd=C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
    if not exist "!_dev_cmd!" set "_dev_cmd=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat"
    if not exist "!_dev_cmd!" set "_dev_cmd="
endlocal & (
    set "PATH=%_path%"
    set "MINGW=%_mingw_root%"
    set "MSVC_DEV_CMD=%_dev_cmd%"
    set "PROJECT_ROOT=%_root%"
    exit /b %ERRORLEVEL%
)

:$Main
setlocal EnableDelayedExpansion
    call :SetPathEnvironment
    echo Initialized environment for 'AltSnap' project.

    if defined VSCMD_VER (
        echo Skipped Visual Studio environment setup as it appears setup already.
        goto:$DevCmdDone
    )

    if not exist "%MSVC_DEV_CMD%" (
        echo Failed to find development command script for Visual Studio.
        goto:$DevCmdDone
    )

    set VSCMD_DEBUG=2
    set "_cmd="%MSVC_DEV_CMD%" -startdir="%PROJECT_ROOT%" -app_platform=Desktop -no_logo -no_ext -arch=x64 -host_arch=x64"
    echo ##[cmd] !_cmd!
    call !_cmd!
    :$DevCmdDone
    goto:$MainEnd

    :$MainEnd
endlocal & (
    set "PATH=%PATH%"
    set "MINGW=%MINGW%"
    set "MSVC_DEV_CMD=%_dev_cmd%"
    set "VSCMD_ARG_app_plat=%VSCMD_ARG_app_plat%"
    set "VSCMD_ARG_HOST_ARCH=%VSCMD_ARG_HOST_ARCH%"
    set "VSCMD_ARG_no_ext=%VSCMD_ARG_no_ext%"
    set "VSCMD_ARG_no_logo=%VSCMD_ARG_no_logo%"
    set "VSCMD_ARG_STARTDIR=%VSCMD_ARG_STARTDIR%"
    set "VSCMD_ARG_TGT_ARCH=%VSCMD_ARG_TGT_ARCH%"
    set "VSCMD_DEBUG=%VSCMD_DEBUG%"
    set "VSCMD_VER=%VSCMD_VER%"
    set "VSINSTALLDIR=%VSINSTALLDIR%"
    set "windir=%windir%"
    set "WindowsLibPath=%WindowsLibPath%"
    set "WindowsSdkBinPath=%WindowsSdkBinPath%"
    set "WindowsSdkDir=%WindowsSdkDir%"
    set "WindowsSDKLibVersion=%WindowsSDKLibVersion%"
    set "WindowsSdkVerBinPath=%WindowsSdkVerBinPath%"
    set "WindowsSDKVersion=%WindowsSDKVersion%"
    set "WIX=%WIX%"
)
cd /d "%~dp0"
exit /b 0
