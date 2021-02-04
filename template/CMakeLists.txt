cmake_minimum_required(VERSION 3.10)

# set the project name
project(#{id}) #Modify this to your project name

# specify the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Put path to NDK such as PATH//TO//NDK
file (STRINGS "ndkpath.txt" CMAKE_ANDROID_NDK)

include_directories(include)
include_directories(extern)
include_directories(shared)
include_directories(extern/libil2cpp/il2cpp/libil2cpp)
# Uncomment these if you use these libraries
# include_directories(extern/codegen/include)
# include_directories(extern/beatsaber-hook/shared)
# include_directories(extern/modloader/shared)
include_directories(${CMAKE_ANDROID_NDK})
include_directories(.)

set(CMAKE_CXX_STANDARD 20)

add_compile_definitions("VERSION=\"0.1.0\"") #Modify this if you use it
add_compile_definitions("ID=\"${CMAKE_PROJECT_NAME}\"") #Modify this if you use it
add_compile_definitions("__GNUC__")
add_compile_definitions("__aarch64__")

file(GLOB SRC src/*.cpp)
add_library(${CMAKE_PROJECT_NAME} SHARED ${SRC}) # Is this necessary? Not sure, have it there anyways
