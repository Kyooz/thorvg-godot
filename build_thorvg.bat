@echo off
REM ThorVG Build Script for Windows
REM Builds optimized ThorVG with multi-threading, SIMD, and Lottie-only support

echo ========================================
echo Building optimized ThorVG library
echo Target: Lottie animations only
echo Optimizations: Multi-threading, SIMD, Partial rendering
echo ========================================
echo.

REM Check for required build tools
where meson >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Meson build system not found in PATH
    echo.
    echo To install dependencies:
    echo   1. Install Python 3.7 or later
    echo   2. Run: pip install meson ninja
    echo   3. Add Python Scripts directory to system PATH
    echo.
    echo Example PATH entry:
    echo   C:\Users\%USERNAME%\AppData\Roaming\Python\Python3XX\Scripts
    echo.
    pause
    exit /b 1
)

where ninja >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Ninja build tool not found in PATH
    echo.
    echo To install: pip install ninja
    echo.
    pause
    exit /b 1
)

echo Build tools verified: Meson and Ninja available
echo.

REM Navigate to ThorVG directory
cd thirdparty\thorvg

REM Clean previous build
if exist builddir (
    echo Cleaning previous build directory...
    rmdir /s /q builddir
)

REM Detect CPU core count for parallel compilation
for /f "tokens=2 delims==" %%i in ('wmic cpu get NumberOfLogicalProcessors /value ^| find "="') do set CORES=%%i

REM Configure build with optimal settings for Lottie rendering
echo Configuring ThorVG build with optimizations...
meson setup builddir ^
  -Dbuildtype=release ^
  -Doptimization=3 ^
  -Db_ndebug=true ^
  -Dsimd=true ^
  -Dthreads=true ^
  -Dpartial=true ^
  -Dengines=sw ^
  -Dloaders=lottie ^
  -Dbindings=capi ^
  -Dexamples=false ^
  -Dcpp_args="-DTHORVG_THREAD_SUPPORT" ^
  --backend=ninja

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to configure build
    pause
    exit /b 1
)

REM Build with all available CPU cores
echo Building ThorVG using %CORES% parallel jobs...
meson compile -C builddir -j %CORES%

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo ThorVG build completed successfully
    echo.
    echo Output location: thirdparty\thorvg\builddir\src\
    echo Library file: thorvg-1.dll / thorvg.lib
    echo.
    echo Enabled optimizations:
    echo   - Multi-threading: Task scheduler with %CORES% workers
    echo   - SIMD instructions: CPU vectorization enabled
    echo   - Partial rendering: Smart update optimizations
    echo   - Lottie loader: JSON animation support only
    echo   - Release mode: Maximum compiler optimizations
    echo ========================================
) else (
    echo.
    echo ERROR: ThorVG build failed
    echo Check the output above for error details
    echo.
    pause
    exit /b 1
)

echo.
echo Build script completed. Ready to build Godot extension.
pause
