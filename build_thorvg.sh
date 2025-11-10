#!/bin/bash

# ThorVG Build Script for Linux/macOS
# Builds optimized ThorVG with multi-threading, SIMD, and Lottie-only support

set -e  # Exit on any error

echo "========================================"
echo "Building optimized ThorVG library"
echo "Target: Lottie animations only"
echo "Optimizations: Multi-threading, SIMD, Partial rendering"
echo "========================================"
echo

# Check for required build tools
if ! command -v meson &> /dev/null; then
    echo "ERROR: Meson build system not found"
    echo
    echo "To install dependencies:"
    echo "  Ubuntu/Debian: sudo apt install meson ninja-build"
    echo "  Fedora/RHEL:   sudo dnf install meson ninja-build"
    echo "  macOS:         brew install meson ninja"
    echo "  Or via pip:    pip3 install meson ninja"
    echo
    exit 1
fi

if ! command -v ninja &> /dev/null; then
    echo "ERROR: Ninja build tool not found"
    echo
    echo "To install:"
    echo "  Ubuntu/Debian: sudo apt install ninja-build"
    echo "  Fedora/RHEL:   sudo dnf install ninja-build"
    echo "  macOS:         brew install ninja"
    echo "  Or via pip:    pip3 install ninja"
    echo
    exit 1
fi

echo "Build tools verified: Meson and Ninja available"
echo

# Navigate to ThorVG directory
cd thirdparty/thorvg

# Clean previous build
if [ -d "builddir" ]; then
    echo "Cleaning previous build directory..."
    rm -rf builddir
fi

# Detect CPU core count for parallel compilation
if command -v nproc &> /dev/null; then
    CORES=$(nproc)
elif [ "$(uname)" == "Darwin" ]; then
    CORES=$(sysctl -n hw.ncpu)
else
    CORES=4  # Fallback
fi

# Configure build with optimal settings for Lottie rendering
echo "Configuring ThorVG build with optimizations..."
meson setup builddir \
    -Dbuildtype=release \
    -Doptimization=3 \
    -Db_ndebug=true \
    -Dsimd=true \
    -Dthreads=true \
    -Dpartial=true \
    -Dengines=sw \
    -Dloaders=lottie \
    -Dbindings=capi \
    -Dexamples=false \
    -Dcpp_args="-DTHORVG_THREAD_SUPPORT" \
    --backend=ninja

# Build with all available CPU cores
echo "Building ThorVG using $CORES parallel jobs..."
meson compile -C builddir -j $CORES

echo
echo "========================================"
echo "ThorVG build completed successfully"
echo
echo "Output location: thirdparty/thorvg/builddir/src/"

# Determine library filename based on platform
if [ "$(uname)" == "Darwin" ]; then
    echo "Library file: libthorvg.dylib"
else
    echo "Library file: libthorvg.so"
fi

echo
echo "Enabled optimizations:"
echo "  - Multi-threading: Task scheduler with $CORES workers"
echo "  - SIMD instructions: CPU vectorization enabled"
echo "  - Partial rendering: Smart update optimizations"  
echo "  - Lottie loader: JSON animation support only"
echo "  - Release mode: Maximum compiler optimizations"
echo "========================================"
echo
echo "Build script completed. Ready to build Godot extension."