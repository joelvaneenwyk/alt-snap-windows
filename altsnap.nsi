# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# define the name of the installer

!define APP_NAME "AltSnap"
!define APP_VERSION "1.62"
# define the name of the installer
OutFile "${APP_NAME}${APP_VERSION}-inst.exe"
Name "${APP_NAME} ${APP_VERSION}"

InstallDir "$APPDATA\${APP_NAME}\"
InstallDirRegKey HKCU "Software\${APP_NAME}" "Install_Dir"
;RequestExecutionLevel user
ShowInstDetails show
ShowUninstDetails show
SetCompressor /SOLID lzma

;!include "LogicLib.nsh"
;!include "FileFunc.nsh"
;!include "x64.nsh"

; The text to prompt the user to enter a directory
DirText "This will install AltSnap on your computer. Choose a directory"
Page directory
Page instfiles
Page custom customPage "" ": custom page"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# DEFAULT SECTION
Section

    Call CloseApp

    # define the output path for this file
    SetOutPath $INSTDIR
    ; Rename old ini file if it exists
    IfFileExists "${APP_NAME}.ini" +2 0
        File AltSnap.ini
    ifFileExists "hooks_x64.dll" 0 +2
        File AltSnap.ini

    # define what to install and place it in the output path
    File AltSnap.exe
    File AltSnap.txt
    File AltSnap.xml
    File hooks.dll
    File LICENSE
    File sch_On.bat
    File sch_Off.bat
    SetOutPath $INSTDIR\languages
    File "languages\_en_US baseline.txt"
    File languages\ca_ES.ini
    File languages\de_DE.ini
    File languages\es_ES.ini
    File languages\fi_FI.ini
    File languages\fr_FR.ini
    File languages\gl_ES.ini
    File languages\it_IT.ini
    File languages\ja_JP.ini
    File languages\ko_KR.ini
    File languages\nb_NO.ini
    File languages\nl_NL.ini
    File languages\pl_PL.ini
    File languages\pt_PR.ini
    File languages\ru_RU.ini
    File languages\sz_SK.ini
    File languages\zh_CN.ini
    File languages\zh_TW.ini

    SetOutPath $INSTDIR\media\themes\erasmion
    File media\themes\erasmion\tray-off.ico
    File media\themes\erasmion\tray-on.ico
    File media\themes\erasmion\tray-sus.ico

    SetOutPath $INSTDIR
    CreateShortcut "$SMPROGRAMS\AltSnap.lnk" "$INSTDIR\AltSnap.exe"

    WriteRegStr HKCU "Software\${APP_NAME}" "Install_Dir" "$INSTDIR"
    WriteRegStr HKCU "Software\${APP_NAME}" "Version" "${APP_VERSION}"

    ; Create uninstaller
    WriteUninstaller "Uninstall.exe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "QuietUninstallString" '"$INSTDIR\Uninstall.exe" /S'
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayIcon" '"$INSTDIR\${APP_NAME}.exe"'
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "HelpLink" "https://github.com/RamonUnch/AltSnap/wiki"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "Raymond Gillibert"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "InstallLocation" "$INSTDIR\"
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1

    ; Compute size for uninstall information
    ;${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
    ;IntFmt $0 "0x%08X" $0
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "EstimatedSize" "400"

SectionEnd

Function customPage
  MessageBox MB_YESNO "Run AltSnap now?" IDNO NoRunNow
    Exec "$INSTDIR\AltSnap.exe" ; view readme or whatever, if you want.
  NoRunNow:
FunctionEnd

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# CLOSEAPP
!define WM_CLOSE 0x0010
!macro CloseApp un
Function ${un}CloseApp
  ; Close app if running
  FindWindow $0 "${APP_NAME}" ""
  IntCmp $0 0 done
    DetailPrint "Attempting to close running ${APP_NAME}..."
    SendMessage $0 ${WM_CLOSE} 0 0 /TIMEOUT=500
    waitloop:
      Sleep 10
      FindWindow $0 "${APP_NAME}" ""
      IntCmp $0 0 closed waitloop waitloop
  closed:
  Sleep 100 ; Sleep a little extra to let Windows do its thing

  done:
FunctionEnd
!macroend
!insertmacro CloseApp ""
!insertmacro CloseApp "un."

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# UNINSTALL
Section "Uninstall"

    Call un.CloseApp

    SetOutPath $INSTDIR
    # Always delete uninstaller first
    Delete "$INSTDIR\Uninstall.exe"

    # now delete installed file
    Delete "$INSTDIR\AltSnap.exe"
    Delete "$INSTDIR\AltSnap.txt"
    Delete "$INSTDIR\AltSnap.xml"
    Delete "$INSTDIR\AltSnap.ini"
    Delete "$INSTDIR\AltSnap-old.ini"
    Delete "$INSTDIR\hooks.dll"
    Delete "$INSTDIR\LICENSE"
    Delete "languages\_en_US baseline.txt"
    Delete languages\ca_ES.ini
    Delete languages\de_DE.ini
    Delete languages\es_ES.ini
    Delete languages\fr_FR.ini
    Delete languages\gl_ES.ini
    Delete languages\it_IT.ini
    Delete languages\ja_JP.ini
    Delete languages\ko_KR.ini
    Delete languages\nb_NO.ini
    Delete languages\nl_NL.ini
    Delete languages\pl_PL.ini
    Delete languages\pt_PR.ini
    Delete languages\ru_RU.ini
    Delete languages\sz_SK.ini
    Delete languages\zh_CN.ini
    Delete languages\zh_TW.ini
    RMDir "$INSTDIR\languages"

    Delete media\themes\erasmion\tray-off.ico
    Delete media\themes\erasmion\tray-on.ico
    Delete media\themes\erasmion\tray-sus.ico
    RMDir "$INSTDIR\media\themes\erasmion"
    RMDir "$INSTDIR\Themes"

    SetOutPath $APPDATA
    RMDir "$INSTDIR"

    Delete $SMPROGRAMS\AltSnap.lnk
    DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "AltSnap"
    DeleteRegKey /ifempty HKCU "Software\AltSnap"
    DeleteRegKey /ifempty HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AltSnap"

SectionEnd
