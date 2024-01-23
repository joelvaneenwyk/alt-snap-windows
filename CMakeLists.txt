cmake_minimum_required(VERSION 3.22)
project(alt_snap)

enable_language(C CXX)
set(CMAKE_C_STANDARD 99)

add_executable(alt_snap)
target_sources(alt_snap PRIVATE
        altsnap.c
        altsnap.rc window.rc
        hooks.h languages.h unfuck.h nanolibc.h resource.h
        AltSnap.exe.manifest
        # media/find.ico media/find.cur
        # media/icon.ico media/tray-disabled.ico media/tray-enabled.ico
)
target_link_libraries(alt_snap
        PRIVATE comctl32 advapi32 shell32 msvcrt kernel32 gdi32
)

if (MSVC)
    message("Building 'AltSnap' with Visual Studio")
    # warning level 4
    target_compile_options(alt_snap
            PRIVATE "/W4"
            PRIVATE "/GF" # String pooling
            PRIVATE "/Gy" # Function-level linking
            PRIVATE "/GR-" # Disable run-time type information
            PRIVATE "/permissive-"
            PRIVATE "/Oy" "/Oi" "/GS-"
            PRIVATE "/TSAWARE"

            # Disable warnings for unsecure CRT functions from VC8+
            PRIVATE "/wd4996"
    )
    target_link_options(alt_snap
            PRIVATE "/opt:ref" # Eliminate unreferenced functions and data
            PRIVATE "/opt:icf" # Perform identical COMDAT folding
            PRIVATE "/nodefaultlib:msvcrt"
            PRIVATE $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:/TSAWARE>
            PRIVATE "/LARGEADDRESSAWARE"
    )
else ()
    message("Building 'AltSnap' with GCC")
    # additional warnings
    target_compile_options(alt_snap
            PRIVATE -Wall
            PRIVATE -Wformat-security
            PRIVATE -Wstrict-overflow
            PRIVATE -Wsign-compare
            PRIVATE -Wclobbered
            PRIVATE -Wempty-body
            PRIVATE -Wignored-qualifiers
            PRIVATE -Wsuggest-attribute=pure
            PRIVATE -Wsuggest-attribute=const
            PRIVATE -Wsuggest-attribute=noreturn
            PRIVATE -Wuninitialized
            PRIVATE -Wtype-limits
            PRIVATE -Woverride-init
            PRIVATE -Wlogical-op
            PRIVATE -Wno-multichar
            PRIVATE -Wno-attributes
            PRIVATE -Wno-unused-function
            PRIVATE -Wshadow
            PRIVATE -Warray-bounds=2
            PRIVATE -Wstack-usage=4096
            PRIVATE -Werror=vla
            PRIVATE -pedantic
            PRIVATE -Wc++-compat
            PRIVATE -Wstringop-overflow=4
            PRIVATE -Wduplicated-cond
            PRIVATE -Wduplicated-branches
            PRIVATE -Wnull-dereference
            PRIVATE -mno-stack-arg-probe
            PRIVATE -momit-leaf-frame-pointer
            PRIVATE -fno-stack-check
            PRIVATE -fno-stack-protector
            PRIVATE -fno-ident
            PRIVATE -fomit-frame-pointer
            PRIVATE -fshort-enums
            PRIVATE -fno-exceptions
            PRIVATE -fno-dwarf2-cfi-asm
            PRIVATE -fno-asynchronous-unwind-tables
            PRIVATE -fmerge-all-constants
            PRIVATE -fno-semantic-interposition
            PRIVATE -fgcse-sm
            PRIVATE -fgcse-las
            PRIVATE -D__USE_MINGW_ANSI_STDIO=0
            PRIVATE -Wp,-D_FORTIFY_SOURCE=2
            PRIVATE -fno-plt
            # PRIVATE -Os -std=c99
            # PRIVATE -finput-charset=UTF-8
            # PRIVATE -fshort-wchar
            # PRIVATE -m32 -march=i386 -mtune=i686
            # PRIVATE -mpreferred-stack-boundary=2
    )
    target_link_options(alt_snap
            PRIVATE -nostdlib
            PRIVATE -lmsvcrt
            PRIVATE -lkernel32
            PRIVATE -luser32
            PRIVATE -lgdi32
            PRIVATE -s
            PRIVATE -Wl,--tsaware
            PRIVATE -Wl,-s,-dynamicbase
            PRIVATE -Wl,-nxcompat
            PRIVATE -Wl,--no-seh
            PRIVATE -Wl,--relax
            PRIVATE -Wl,--disable-runtime-pseudo-reloc
            PRIVATE -Wl,--enable-auto-import
            PRIVATE -Wl,--disable-stdcall-fixup
            PRIVATE -mwindows -e_unfuckWinMain@0
    )
endif ()
