setlocal

set myConfig=%1
set myUse_MyMath=%2

if exist .\build_dir (
	rmdir /q /s .\build_dir
)

if not exist .\build_dir (
	mkdir .\build_dir
)

if exist .\install_dir (
	rmdir /q /s .\install_dir
)

rem USE_MYMATH defaults to OFF, 0 or false if not supplied
rem pass ON, 1 or true as a parameter to .\build
rem to use custom mysqrt function.
rem Examples:
rem .\build ON
rem .\build 1
rem .\build true
if exist .\build_dir (
	cd .\build_dir
	cmake .. -DUSE_MYMATH=%myUse_MyMath% -DCMAKE_INSTALL_PREFIX=../install_dir -DCMAKE_BUILD_TYPE=%myConfig%
	cmake --build . --clean-first --verbose --config %myConfig% --parallel 8
	cmake --install . --prefix "../install_dir" -v --config %myConfig%
rem Note: ../install_dir/lib is created only when USE_MYMATH=ON, 1 or true
)

endlocal