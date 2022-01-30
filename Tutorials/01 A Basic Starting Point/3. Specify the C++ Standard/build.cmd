setlocal

if exist .\build_dir (
	rmdir /q /s .\build_dir
)

if not exist .\build_dir (
	mkdir .\build_dir
)

if exist .\build_dir (
	cd .\build_dir
	cmake ..
	cmake --build .
)

endlocal