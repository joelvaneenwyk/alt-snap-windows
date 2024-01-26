# AltSnap

English | [中文](./README_zh-CN.md) | [한국어](./README_ko-KR.md)

Fork from [Stefan Sundin's AltDrag](https://github.com/stefansundin/AltSnap).

- Check the Wiki: <https://github.com/RamonUnch/AltSnap/wiki>
- Original documentation: <https://stefansundin.github.io/altdrag/doc/>

Note that the documentation is not 100% accurate because it is a fork. Read the changelog for more details.

It allows you to move and resize windows by using the Alt key and clicking wherever on the window instead of relying
on very precise clicking. This behavior is very common on Linux distributions and is not actually hard to implement on Windows.

This fork tries to keep a version up to date with minimal amount of bugs while keeping it feature-rich.

It is oriented towards all Windows users from Windows NT 4 to Windows 11, even though it is mostly tested on Windows XP and Windows 10.

## Main Differences

- To simplify the code greatly the **Hooks** Windows feature was removed, it allowed you have windows snapping while dragging them normally. It required however to inject a dll in every application and induced thus an obvious security risk. The amount of mess added to the code just for this feature was substantial and in addition forced to have both a 32bits and a 64bits version of the program running at the same time.
- This version injects nothing into other applications. This means you do not have to worry whether you have a 32 or a 64bit operating system.
- Another feature that was disabled is focus on typing, that was too much unusable for me to even start testing, so I removed it.
- Otherwise this has a much simpler source code, added a few extra options, such as transparent windows dragging, Maximize action, pause process options, more blacklists for finer control of AltSnap etc.
- Finally it fixed a ton of undesired behavior and bugs from the original AltDrag.

## What's New

Many new features can be seen in the option dialog box, however some of them are only available through editing the `AltSnap.ini` file (middle click on the tray icon for this).

## VirusTotal false positive

You will see with the latest builds that there are some alerts, usually from SecureAge APEX sometime also from another vendor. Those are false positive and I stopped to contact the APEX team for every release because it is a loss of time I would rather spend on improving the program.

I already reduced a lot the number of false positive, simply by changing build flags and by switching to an older version of NSIS installer system. This is an indication of the impertinence of some modern antivirus solutions. Chocolatey considers that up to 5 positives on VirusTotal is not even suspicious.

## Build

AltSnap builds with GCC and is tested with `mingw-w64` for `i686` builds.

Install the latest version (e.g., TDM-gcc 10.3 which is based on `MinGW64`) and use one of the following commands to build.

Be sure to adjust your include and lib directories on the command line with `-IPath\to\mingw\include` and `-LPath\to\mingw\lib`.

### Make i386 Win32

For `i386` Win32 GCC build.

```bash
make
```

### Make i386 GCC

For `i386` GCC debug build.

```bash
make -fMakefileDebug
```

### Make `x86_64` GCC

For `x86_64` GCC build.

```bash
make -fMakefileX64
```

### Make `x86_64` GCC Debug

For `x86_64` GCC debug build.

```bash
make -fMakefileX64Debug
```

### Make `i386` Clang

For `i386` build using LLVM Clang. We recommend using the LLVM5.0.1 with the headers and libs from `mingw-w64`.

```bash
make -fMakefileClang
```

### Make `i386` Tiny C

For `i386` build using `tcc`, [Bellard's Tiny C Compiler](https://bellard.org/tcc/).

```bash
make -fMakefileTCC
```
