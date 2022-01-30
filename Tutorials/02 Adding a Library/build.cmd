setlocal

if exist .\build_dir (
	rmdir /q /s .\build_dir
)

if not exist .\build_dir (
	mkdir .\build_dir
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
	cmake .. -DUSE_MYMATH=%1
	cmake --build .
)

endlocal