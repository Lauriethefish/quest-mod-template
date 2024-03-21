cmake_minimum_required(VERSION 3.22)

option(QUEST "Build for quest" ON)

# Globals
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)


add_compile_definitions(MOD_ID="${CMAKE_PROJECT_NAME}")
add_compile_definitions(VERSION="${CMAKE_PROJECT_VERSION}")

add_compile_options(-frtti -fexceptions -fvisibility=hidden -fPIE -fPIC)


# Include

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/utils.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/qpm.cmake)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/builds/release.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/builds/debug.cmake)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/builds/strip.cmake)

if(QUEST)
        include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/targets/quest.cmake)
endif()

# stop symbols leaking
# TODO: Fix
# add_link_options(-Wl, --exclude-libs, ALL)

project(#{id}
        VERSION ${PACKAGE_VERSION})
# Set COMPILE_ID for qpm purposes
set(COMPILE_ID ${CMAKE_PROJECT_NAME})


# recursively get all src files
RECURSE_FILES(cpp_file_list ${SOURCE_DIR}/*.cpp)
RECURSE_FILES(c_file_list ${SOURCE_DIR}/*.c)

add_library(
        ${CMAKE_PROJECT_NAME}
        SHARED
        ${cpp_file_list}
        ${c_file_list}
)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${INCLUDE_DIR})
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${SHARED_DIR})



