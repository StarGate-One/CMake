cmake_minimum_required(VERSION 3.20)

# set the project name and version
project(Tutorial VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# should we use our own math functions
option(USE_MYMATH "Use tutorial provided custom math implementation" OFF)

# configure header file to pass CMake settings to source
configure_file(TutorialConfig.h.in TutorialConfig.h)

# add the MathFunctions library if turned on
if(USE_MYMATH)
	add_subdirectory(MathFunctions)
	list(APPEND EXTRA_LIBS MathFunctions)
endif()

# add the executable
add_executable(Tutorial tutorial.cxx)

# add extra libraries
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

# add the binary tree to search path for include files
# so we find the TutorialConfig.h
target_include_directories(Tutorial PUBLIC 
                          "${PROJECT_BINARY_DIR}"
                          )
