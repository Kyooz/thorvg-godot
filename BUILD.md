# Build Configuration

This document describes the build system and optimization settings for ThorVG-Godot.

## ThorVG Build Options

The project uses optimized ThorVG builds with the following configuration:

### Core Settings
- **Build Type**: Release with maximum optimizations (-O3)
- **Target**: Lottie animation rendering only
- **Debugging**: Disabled (NDEBUG=true)

### Performance Optimizations
- **SIMD**: Automatic CPU vectorization (AVX/SSE/NEON)
- **Multi-threading**: Parallel task scheduler 
- **Partial Rendering**: Smart update optimizations
- **Memory Pool**: Optimized allocation strategies

### Feature Selection
- **Engines**: Software rendering only (SW engine)
- **Loaders**: Lottie format only (excludes SVG, PNG, JPG, etc.)
- **Bindings**: C API for Godot integration
- **Tools**: Excluded to minimize build size

## Platform Support

### Windows
- **Compiler**: MSVC 2019+ (Visual Studio or Build Tools)
- **Architecture**: x86_64
- **Library**: Dynamic link library (thorvg-1.dll)
- **Build Script**: `build_thorvg.bat`

### Linux
- **Compiler**: GCC 8+ or Clang 10+
- **Architecture**: x86_64, ARM64
- **Library**: Shared object (libthorvg.so)
- **Build Script**: `build_thorvg.sh`

### macOS  
- **Compiler**: Clang (Xcode Command Line Tools)
- **Architecture**: x86_64, ARM64 (Apple Silicon)
- **Library**: Dynamic library (libthorvg.dylib)
- **Build Script**: `build_thorvg.sh`

## Build Dependencies

### Required
- Python 3.7 or later
- Meson build system (0.55+)
- Ninja build tool
- Platform C++ compiler

### Installation Commands

**Windows (PowerShell):**
```powershell
pip install meson ninja
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install python3-pip meson ninja-build build-essential
```

**Fedora/CentOS/RHEL:**
```bash
sudo dnf install python3-pip meson ninja-build gcc-c++
```

**macOS:**
```bash
brew install python3 meson ninja
# Or via pip after installing Python
pip3 install meson ninja
```

## Compiler Flags

The build system automatically applies optimal compiler flags:

### MSVC (Windows)
- `/O2` - Maximum optimization 
- `/GL` - Whole program optimization
- `/LTCG` - Link-time code generation
- `/arch:AVX2` - SIMD instructions (if supported)

### GCC/Clang (Linux/macOS)
- `-O3` - Maximum optimization
- `-DNDEBUG` - Remove debug assertions
- `-march=native` - CPU-specific optimizations
- `-mtune=native` - CPU-specific tuning

## Verification

After building, verify the optimizations are active:

1. Check build output for SIMD confirmation
2. Verify multi-threading is enabled  
3. Confirm only Lottie loader is built
4. Test library linking in Godot project

## Troubleshooting

### Common Issues

**Build fails with "meson not found":**
- Install Python and meson via pip
- Add Python Scripts directory to PATH

**Compiler not detected:**
- Install platform development tools
- Verify compiler is in system PATH

**Library linking errors:**
- Ensure ThorVG was built successfully
- Check library file exists in expected location
- Verify platform-specific library format (.dll/.so/.dylib)