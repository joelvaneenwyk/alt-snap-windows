@echo off
setlocal EnableDelayedExpansion
    call "%~dp0env.bat"

    set "DEFINES=/D "DWORD_PTR=DWORD""
    set "DEFINES=!DEFINES! /D "LONG_PTR=INT_PTR""
    set "DEFINES=!DEFINES! /D "ULONG_PTR=DWORD""
    set "DEFINES=!DEFINES! /D "NO_VISTA""
    set "DEFINES=!DEFINES! /D "NO_OLEAPI""
    set "DEFINES=!DEFINES! /D "DECORATED_HOOKS_DLL_PROCS""

    rc "%~dp0hooks.rc"
    rc "%~dp0altsnap.rc"

    cl /c /Tp altsnap.c /nologo /Ox /Oi /Os /Gy !DEFINES!

    link ^
        altsnap.obj altsnap.res ^
        /nodefaultlib /filealign:512 /subsystem:windows /OPT:REF /OPT:ICF,7 ^
        /LARGEADDRESSAWARE /machine:I386 /entry:unfuckWinMain ^
        kernel32.lib user32.lib shell32.lib advapi32.lib gdi32.lib comctl32.lib

    cl /c /Tp hooks.c /nologo /Ox /Oi /Os /Gy /GS- /LD !DEFINES!

    link ^
        hooks.obj hooks.res /nodefaultlib /DLL /filealign:512 ^
        /subsystem:windows /OPT:REF /OPT:ICF,7 /LARGEADDRESSAWARE ^
        /machine:I386 /entry:DllMain ^
        kernel32.lib user32.lib gdi32.lib
endlocal & goto:EOF
