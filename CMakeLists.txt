cmake_minimum_required(VERSION 3.22)

include(cmake/kernel.cmake)

set(CMAKE_C_COMPILER_WORKS ON)
set(CMAKE_CXX_COMPILER_WORKS ON)

project(kernel
        VERSION 0.1
        LANGUAGES CXX ASM
        DESCRIPTION "A small kernel attempt")

set(${PROJECT_NAME}_RESOURCE_DIR "${${PROJECT_NAME}_SOURCE_DIR}/resource")


if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    set(CMAKE_CXX_STANDARD 23)
    set(CMAKE_CXX_EXTENSIONS OFF)
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    set(CMAKE_CXX_FLAGS "-ffreestanding -Wall -Wextra -fno-exceptions -fno-rtti")
    set(CMAKE_EXE_LINKER_FLAGS "-T ${${PROJECT_NAME}_RESOURCE_DIR}/linker.ld -nostartfiles -nostdlib -lgcc")




    # Testing only available if this is the main app
    # Note this needs to be done in the main CMakeLists
    # since it calls enable_testing, which must be in the
    # main CMakeLists.

    # Docs only available if this is the main app
    find_package(Doxygen)
    if(Doxygen_FOUND)
        add_subdirectory(docs)
    else()
        message(STATUS "Doxygen not found, not building docs")
    endif()
endif()

add_subdirectory(src)
