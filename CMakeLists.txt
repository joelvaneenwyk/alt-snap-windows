cmake_minimum_required(VERSION 3.27)
project(alt_snap)

set(CMAKE_CXX_STANDARD 17)
set(CC, gcc)
set(WR, windres)
set(WARNINGS,
        -Wall
        -Wformat-security
        -Wstrict-overflow
        -Wsign-compare
        -Wclobbered
        -Wempty-body
        -Wignored-qualifiers
        -Wsuggest-attribute=pure
        -Wsuggest-attribute=const
        -Wsuggest-attribute=noreturn
        -Wuninitialized
        -Wtype-limits
        -Woverride-init
        -Wlogical-op
        -Wno-multichar
        -Wno-attributes
        -Wno-unused-function
        -Wshadow
        -Warray-bounds=2
        -Wstack-usage=4096
        -Werror=vla
        -pedantic
        -Wc++-compa
        -Wstringop-overflow=4
        -Wduplicated-cond
        -Wduplicated-branches
        -Wnull-dereference
        # -Wunused-parameter
        # -Wtraditional-conversion
        # -fira-region=one/mixed
        # -Wstack-usage=2048
        # -finput-charset=UTF-8
        # -Wc++-compat
        # -fmerge-all-constants
)

set(CFLAGS,
        -Os -std=c99
        -finput-charset=UTF-8
        -fshort-wchar
        -m32 -march=i386 -mtune=i686
        -mno-stack-arg-probe
        -mpreferred-stack-boundary=2
        -momit-leaf-frame-pointer
        -fno-stack-check
        -fno-stack-protector
        -fno-ident
        -fomit-frame-pointer
        -fshort-enums
        -fno-exceptions
        -fno-dwarf2-cfi-asm
        -fno-asynchronous-unwind-tables
        -fmerge-all-constants
        -fno-semantic-interposition
        -fgcse-sm
        -fgcse-las
        -D__USE_MINGW_ANSI_STDIO=0
        -Wp,-D_FORTIFY_SOURCE=2
        ${WARNINGS}
        -fno-plt)

set(LDFLAGS,
        -nostdlib
        -lmsvcrt
        -lkernel32
        -luser32
        -lgdi32
        -s
        -Wl,-s,-dynamicbase
        -Wl,-nxcompat
        -Wl,--no-seh
        -Wl,--relax
        -Wl,--disable-runtime-pseudo-reloc
        -Wl,--enable-auto-import
        -Wl,--disable-stdcall-fixup
)

set(EXELD,
        ${LDFLAGS}
        -Wl,--tsaware
        -lcomctl32
        -ladvapi32
        -lshell32
        -Wl
)


add_library(alt_snap_hooks
        hooks.c hooks.h hooks.rc unfuck.h nanolibc.h zones.c snap.c
)

add_executable(alt_snap
        altsnap.c hooks.h tray.c config.c languages.h languages.c unfuck.h nanolibc.h
        altsnap.rc window.rc resource.h AltSnap.exe.manifest media/find.cur
        media/find.ico media/icon.ico media/tray-disabled.ico media/tray-enabled.ico
)

if (MSVC)
    # warning level 4
    add_compile_options(/W4)
else ()
    # additional warnings
    add_compile_options(alt_snap
            ${CFLAGS}
    )
    add_link_options(alt_snap
            ${LDFLAGS}
            ${EXELD}
    )
endif ()
