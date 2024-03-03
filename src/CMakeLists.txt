file(GLOB CORE_HEADER_LIST CONFIGURE_DEPENDS "${${PROJECT_NAME}_SOURCE_DIR}/include/*.hpp")
add_executable(${PROJECT_NAME}
        asm/boot.s
        cxx/kernel.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.bin")
target_include_directories(${PROJECT_NAME} PUBLIC ${${PROJECT_NAME}_SOURCE_DIR}/include/)
add_iso(${PROJECT_NAME}
    FS ${${PROJECT_NAME}_RESOURCE_DIR}/iso)