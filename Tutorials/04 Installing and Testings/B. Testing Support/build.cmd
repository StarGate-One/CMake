@setlocal

@if "%1"=="" @goto usage
@if "%2"=="" @goto usage

@set myConfig=%1
@set myUse_myMath=%2

@if not defined myConfig @goto usage
@if not defined myUse_myMath @goto usage

@if "%myConfig%" NEQ "All" (
    @if "%myConfig%" NEQ "Debug" (
       @if "%myConfig%" NEQ "Release" (
           @goto usage
       )
    )
)

@if "%myUse_myMath%" NEQ "0" (
    @if "%myUse_myMath%" NEQ "1" (
        @if "%myUse_myMath%" NEQ "False" (
            @if "%myUse_myMath%" NEQ "True" (
                @if "%myUse_myMath%" NEQ "OFF" (
                    @if "%myUse_myMath%" NEQ "ON" (
                        @goto usage
                    )
                )
            )
        )
    )
)

@if exist .\build_dir (
   @rmdir /q /s .\build_dir
)

@if not exist .\build_dir (
   @mkdir .\build_dir
)

@if exist .\install_dir (
   @rmdir /q /s .\install_dir
)

@rem USE_MYMATH defaults to OFF, 0 or false if not supplied
@rem pass ON, 1 or true as a parameter to .\build
@rem to use custom mysqrt function.
@rem Examples:
@rem .\build release ON
@rem .\build debug 1
@rem .\build both true
@rem Note: ../install_dir/lib is created only when USE_MYMATH=ON, 1 or true

@if exist .\build_dir (
   @cd .\build_dir

   @rem cmake .. -DUSE_MYMATH=%myUse_myMath% -DCMAKE_CONFIGURATION_TYPES=Debug;Release -DCMAKE_INSTALL_PREFIX=../install_dir
   cmake -S ../ -B ./ -G "Visual Studio 16 2019" -A x64 -T v142 -DUSE_MYMATH=%myUse_myMath% -DCMAKE_CONFIGURATION_TYPES=Debug;Release 

   @rem Build Debug Configuration
   @if %myConfig% NEQ "Release" (
       @rem cmake -S ../ -B ./Debug -G "Visual Studio 16 2019" -A x64 -T v142 -DUSE_MYMATH=%myUse_myMath% -DCMAKE_CONFIGURATION_TYPES=Debug -DCMAKE_INSTALL_PREFIX=../install_dir/Debug -DCMAKE_BUILD_TYPE=Debug
       cmake --build ./ --clean-first --verbose --parallel 8 --target ALL_BUILD --config=Debug
       cmake --install ./ --prefix "../install_dir/Debug" -v --config Debug
       ctest -C Debug -N >./Tests_Debug.log 2>&1
       ctest -C Debug -VV >>./Tests_Debug.log 2>>&1
   )

   @rem Build Release Configuration
   @if %myConfig% NEQ "Debug" (
       @rem cmake -S ../ -B ./Release -G "Visual Studio 16 2019" -A x64 -T v142 -DUSE_MYMATH=%myUse_myMath% -DCMAKE_CONFIGURATION_TYPES=Release -DCMAKE_INSTALL_PREFIX=../install_dir/Release -DCMAKE_BUILD_TYPE=Release
       cmake --build ./ --clean-first --verbose --parallel 8 --target ALL_BUILD --config=Release
       cmake --install ./ --prefix "../install_dir/Release" -v --config Release
       ctest -C Release -N >./Tests_Release.log 2>&1
       ctest -C Release -VV >>./Tests_Release.log 2>>&1
   )
)

goto end

:usage
@cls
@echo.
@echo.
@echo.
@echo Usage: .\build.cmd Parm1 Parm2
@echo Where: Parm1 = Both or Debug or Release
@echo        Parm2 = 0 or False or OFF or 1 or True or ON
@echo.
@echo Examples:
@echo .\build.cmd All 0
@echo .\build.cmd Debug False
@echo .\build cmd Release OFF
@echo .\build.cmd All 1
@echo .\build.cmd Debug True
@echo .\build cmd Release ON

:end

@endlocal