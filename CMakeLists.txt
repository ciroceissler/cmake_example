cmake_minimum_required (VERSION 2.8)

project (cmake_example)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})

#------------------------------------------------------------------------------
# FFTW
#------------------------------------------------------------------------------
set(USE_SYSTEM_FFTW OFF CACHE BOOL "Use system FFTW")

include(External_FFTW)

include_directories( ${FFTW_INCLUDES} )

#------------------------------------------------------------------------------
# SystemC
#------------------------------------------------------------------------------
set(USE_SYSTEM_SYSTEMC OFF CACHE BOOL "Use system SystemC")

include(External_SystemC)

include_directories( ${SYSTEMC_INCLUDES} )

#------------------------------------------------------------------------------
# OpenMP
#------------------------------------------------------------------------------
find_package(OpenMP)

if (OPENMP_FOUND)
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
else()
  message( FATAL_ERROR "OpenMP library not found." )
endif()

#------------------------------------------------------------------------------
# Include
#------------------------------------------------------------------------------
include_directories( ${CMAKE_CURRENT_BINARY_DIR} )
include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )

#------------------------------------------------------------------------------
# Flags
#------------------------------------------------------------------------------
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -g -D_SIM_DDLMS_")

#------------------------------------------------------------------------------
# Exec
#------------------------------------------------------------------------------
add_executable(cmake_example main.cpp)

target_link_libraries(cmake_example ${FFTW_LIBRARIES} ${SYSTEMC_LIBRARIES} m)

#------------------------------------------------------------------------------
# Tests
#------------------------------------------------------------------------------
enable_testing()

add_test(NAME test1  COMMAND cmake_example)
add_test(NAME test2  COMMAND cmake_example)
add_test(NAME test3  COMMAND cmake_example)
add_test(NAME test4  COMMAND cmake_example)
add_test(NAME test5  COMMAND cmake_example)
add_test(NAME test6  COMMAND cmake_example)
add_test(NAME test7  COMMAND cmake_example)
add_test(NAME test8  COMMAND cmake_example)
add_test(NAME test9  COMMAND cmake_example)
add_test(NAME test10 COMMAND cmake_example)
