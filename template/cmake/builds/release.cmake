include_guard()

if(${CMAKE_BUILD_TYPE} STREQUAL "RELEASE" OR ${CMAKE_BUILD_TYPE} STREQUAL "RelWithDebInfo" OR ${CMAKE_BUILD_TYPE} STREQUAL "MinSizeRel")
    # Better optimizations
    add_compile_options(-O3)
    
    # LTO
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
    add_compile_options(-flto)


    # Strip debug symbols
    add_custom_command(TARGET ${COMPILE_ID} POST_BUILD
        COMMAND ${CMAKE_STRIP} -d --strip-all
        "lib${COMPILE_ID}.so" -o "stripped_lib${COMPILE_ID}.so"
        COMMENT "Strip debug symbols done on final binary.")

    add_custom_command(TARGET ${COMPILE_ID} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory debug
        COMMENT "Make directory for debug symbols"
    )
    add_custom_command(TARGET ${COMPILE_ID} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E rename lib${COMPILE_ID}.so debug/lib${COMPILE_ID}.so
        COMMENT "Rename the lib to debug_ since it has debug symbols"
    )
    # strip debug symbols from the .so and all dependencies
    add_custom_command(TARGET ${COMPILE_ID} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E rename stripped_lib${COMPILE_ID}.so lib${COMPILE_ID}.so
        COMMENT "Rename the stripped lib to regular"
    )
endif()