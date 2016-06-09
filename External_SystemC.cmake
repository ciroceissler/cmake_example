#
# Encapsulates building SystemC as an External Project.

#--Some influential environment variables:
#--  CC          C compiler command
#--  CFLAGS      C compiler flags
#--  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
#--              nonstandard directory <lib dir>
#--  LIBS        libraries to pass to the linker, e.g. -l<library>
#--  CPPFLAGS    C/C++/Objective C preprocessor flags, e.g. -I<include dir> if
#--              you have headers in a nonstandard directory <include dir>
#-- set(ENV{CC}       "${CMAKE_C_COMPILER}")
#-- set(ENV{CFLAGS}   "${CMAKE_C_FLAGS} ${OPENMP_FLAG}")
#-- set(ENV{LDFLAGS}  "${CMAKE_C_FLAGS} ${OPENMP_FLAG}")
#-- set(ENV{LIBS}     "${CMAKE_EXE_LINKER_FLAGS} ${OPENMP_FLAG}")
#-- set(ENV{CPPFLAGS} "${CMAKE_C_FLAGS} ${OPENMP_FLAG}")

set(SYSTEMC_OPTIMIZATION_CONFIGURATION "" CACHE INTERNAL "architecture flags: --enable-sse --enable-sse2 --enable-altivec --enable-mips-ps --enable-cell")

if(USE_SYSTEM_SYSTEMC)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")
  find_package(SystemC 2.3.1 REQUIRED)
else()
  set(SYSTEMC_COMPILER_FLAGS
    CC=${CMAKE_C_COMPILER}
    CXX=${CMAKE_CXX_COMPILER}
    CFLAGS=${CMAKE_C_FLAGS}
    CXXFLAGS=${CMAKE_CXX_FLAGS})

  set(SYSTEMC_SHARED_FLAG --enable-shared)
  set(SYSTEMC_VERSION 2.3.1)
  set(SYSTEMC_MD5 "a6437844f7961c4e47d9593312f6311c")
  set(SYSTEMC_URL_PRE "http://accellera.org/images/downloads/standards/systemc/systemc-")
  set(SYSTEMC_URL_POST ".tgz")
  set(SYSTEMC_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/systemc/install)
  set(SYSTEMC_LIBRARIES_PATH ${SYSTEMC_INSTALL_DIR}/lib-linux64/)
  set(SYSTEMC_LIBRARIES
    ${SYSTEMC_LIBRARIES_PATH}${CMAKE_SHARED_LIBRARY_PREFIX}systemc${CMAKE_SHARED_LIBRARY_SUFFIX})

  include(ExternalProject)
  ExternalProject_add(SYSTEMC
    URL ${SYSTEMC_URL_PRE}${SYSTEMC_VERSION}${SYSTEMC_URL_POST}
    URL_MD5 ${SYSTEMC_MD5}
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/systemc/src
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/3rdparty/systemc/src
    INSTALL_DIR ${SYSTEMC_INSTALL_DIR}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND <SOURCE_DIR>/configure
      ${SYSTEMC_SHARED_FLAG}
      ${SYSTEMC_OPTIMIZATION_CONFIGURATION}
      --prefix=<INSTALL_DIR>
      ${SYSTEMC_COMPILER_FLAGS}
  )

  set(SYSTEMC_INCLUDES ${SYSTEMC_INSTALL_DIR}/include)
endif()
