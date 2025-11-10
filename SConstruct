#!/usr/bin/env python

"""
ThorVG-Godot Build Configuration
Builds optimized Lottie animation extension for Godot Engine
"""

import os
import sys

env = SConscript("thirdparty/godot-cpp/SConstruct")

# Source files
env.Append(CPPPATH=["src/"])
sources = Glob("src/*.cpp")

# ThorVG integration - Platform-specific library handling
env.Append(CPPPATH=["thirdparty/thorvg/inc"])

# Determine ThorVG library location and linking method
if env["platform"] == "web":
    thorvg_lib_dir = os.path.join("thirdparty", "thorvg", "build_wasm", "src")
else:
    thorvg_lib_dir = os.path.join("thirdparty", "thorvg", "builddir", "src")

if os.path.exists(thorvg_lib_dir):
    env.Append(LIBPATH=[thorvg_lib_dir])
    
    # Platform-specific library files
    platform_libs = {
        "windows": [
            ("thorvg.lib", lambda: env.Append(LIBS=["thorvg"])),
            ("libthorvg.a", lambda: env.Append(LINKFLAGS=[os.path.join(thorvg_lib_dir, "libthorvg.a")]))
        ],
        "linux": [
            ("libthorvg.so", lambda: env.Append(LIBS=["thorvg"])),
            ("libthorvg.a", lambda: env.Append(LIBS=["thorvg"]))
        ],
        "macos": [
            ("libthorvg.dylib", lambda: env.Append(LIBS=["thorvg"])),
            ("libthorvg.a", lambda: env.Append(LIBS=["thorvg"]))
        ]
    }
    
    # Try to find and link appropriate library for current platform
    lib_found = False
    if env["platform"] in platform_libs:
        for lib_name, link_func in platform_libs[env["platform"]]:
            lib_path = os.path.join(thorvg_lib_dir, lib_name)
            if os.path.isfile(lib_path):
                link_func()
                lib_found = True
                print("Using ThorVG library: {}".format(lib_name))
                break
    
    if not lib_found:
        print("Warning: ThorVG library not found in {}".format(thorvg_lib_dir))
        print("Available files:", os.listdir(thorvg_lib_dir) if os.path.exists(thorvg_lib_dir) else "Directory not found")
else:
    print("Error: ThorVG build directory not found: {}".format(thorvg_lib_dir))
    print("Please run the appropriate build script first:")
    print("  Windows: build_thorvg.bat") 
    print("  Linux/macOS: ./build_thorvg.sh")

# Output library name
if env["platform"] == "macos":
    library = env.SharedLibrary(
        "demo/addons/godot_lottie/bin/libgodot_lottie.{}.{}.framework/libgodot_lottie.{}.{}".format(
            env["platform"], env["target"], env["platform"], env["target"]
        ),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "demo/addons/godot_lottie/bin/libgodot_lottie{}{}".format(env["suffix"], env["SHLIBSUFFIX"]),
        source=sources,
    )

Default(library)
