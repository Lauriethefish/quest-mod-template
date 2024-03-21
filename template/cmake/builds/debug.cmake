include_guard()

if(${CMAKE_BUILD_TYPE} STREQUAL "DEBUG" OR ${CMAKE_BUILD_TYPE} STREQUAL "RelWithDebInfo")
    add_compile_options(-g)
endif()