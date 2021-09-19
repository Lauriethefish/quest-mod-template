cmake_minimum_required(VERSION 3.10)

# set the project name
project(#{id}) #Modify this to your project name

# specify the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# NDK Magic.
# Note: On Windows, Use WSL with NDK installed in WSL too. 
# For CLion, you'll likely also need to provide `-DCMAKE_ANDROID_NDK=/path/to/ndk/` in CMake options.

# Put path to NDK such as PATH//TO//NDK
if (NOT DEFINED CMAKE_ANDROID_NDK)
    if(DEFINED ENV{ANDROID_NDK_ROOT})
        set(ANDROID_NDK_ROOT ENV{ANDROID_NDK_ROOT})
    else()
        file (STRINGS "ndkpath.txt" CMAKE_ANDROID_NDK)
    endif()
endif()

set(CMAKE_SYSTEM_NAME Android)
set(ANDROID_NATIVE_API_LEVEL 25)
set(ANDROID_ABI arm64-v8a)
set(CMAKE_ANDROID_ARCH_ABI arm64-v8a)
set(ANDROID_TARGET_ARCH arm64-v8a)
set(CMAKE_ANDROID_STL_TYPE c++_static)

set(CMAKE_C_COMPILER_TARGET aarch64-none-linux-android24)
set(CMAKE_CXX_COMPILER_TARGET aarch64-none-linux-android24)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_ANDROID_NDK}/build/cmake/android.toolchain.cmake)

message("Using NDK ${CMAKE_ANDROID_NDK}")

# Source files

include_directories(include)
include_directories(extern)
include_directories(shared)
include_directories(extern/libil2cpp/il2cpp/libil2cpp)
# Uncomment these if you use these libraries
include_directories(extern/codegen/include) # uncomment if no use

include_directories(${CMAKE_ANDROID_NDK})
include_directories(.)

set(CMAKE_CXX_STANDARD 20)

add_compile_definitions("VERSION=\"0.1.0\"") #Modify this if you use it
add_compile_definitions("ID=\"${CMAKE_PROJECT_NAME}\"") #Modify this if you use it
add_compile_definitions("__GNUC__")
add_compile_definitions("__aarch64__")

file(GLOB SRC src/*.cpp)
add_library(${CMAKE_PROJECT_NAME} SHARED ${SRC}) # Is this necessary? Not sure, have it there anyways
