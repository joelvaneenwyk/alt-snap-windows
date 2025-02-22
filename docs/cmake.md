# `windows-alt-snap` | CMake

```log
LINK: command "C:\PROGRA~1\MIB055~1\2022\ENTERP~1\VC\Tools\MSVC\1439~1.335\bin\Hostx64\x64\link.exe /nologo @CMakeFiles\alt_snap.dir\objects1.rsp /out:alt_snap.exe /implib:alt_snap.lib /pdb:D:\src\windows-alt-snap\cmake-build-debug\alt_snap.pdb /version:0.0 /machine:x64 /debug /INCREMENTAL /subsystem:console /opt:ref /opt:icf /nodefaultlib /TSAWARE /INCREMENTAL:NO /LARGEADDRESSAWARE comctl32.lib advapi32.lib shell32.lib msvcrt.lib kernel32.lib gdi32.lib kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib /MANIFEST:EMBED,ID=1" failed (exit code 1120) with the following output:
msvcrt.lib(error.obj) : error LNK2019: unresolved external symbol strcpy_s referenced in function "void __cdecl _RTC_StackFailure(void *,char const *)" (?_RTC_StackFailure@@YAXPEAXPEBD@Z)
msvcrt.lib(error.obj) : error LNK2019: unresolved external symbol strcat_s referenced in function "void __cdecl _RTC_StackFailure(void *,char const *)" (?_RTC_StackFailure@@YAXPEAXPEBD@Z)
msvcrt.lib(error.obj) : error LNK2019: unresolved external symbol __stdio_common_vsprintf_s referenced in function _vsprintf_s_l
msvcrt.lib(error.obj) : error LNK2001: unresolved external symbol __C_specific_handler_noexcept
msvcrt.lib(pdblkup.obj) : error LNK2019: unresolved external symbol __vcrt_GetModuleFileNameW referenced in function "int __cdecl _RTC_GetSrcLine(unsigned char *,wchar_t *,unsigned long,int *,wchar_t *,unsigned long)" (?_RTC_GetSrcLine@@YAHPEAEPEA_WKPEAH1K@Z)
msvcrt.lib(pdblkup.obj) : error LNK2019: unresolved external symbol __vcrt_LoadLibraryExW referenced in function "struct HINSTANCE__ * __cdecl GetPdbDllFromInstallPath(void)" (?GetPdbDllFromInstallPath@@YAPEAUHINSTANCE__@@XZ)
alt_snap.exe : fatal error LNK1120: 6 unresolved externals
```
