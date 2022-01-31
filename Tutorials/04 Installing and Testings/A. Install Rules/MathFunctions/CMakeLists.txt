# use our custom mysqrt function
add_library(MathFunctions mysqrt.cxx)

# state to anybody linking to this project needs
# to include the current source directory to find
# MathFunctions.h
target_include_directories(MathFunctions
       INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
	   )

# our install rules
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
