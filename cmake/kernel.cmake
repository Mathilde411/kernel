cmake_minimum_required(VERSION 3.22)

function(add_iso target)
    cmake_parse_arguments(PARSE_ARGV 1
            ISO
            ""
            "TARGET;FS;OUTPUT"
            ""
    )

    if(DEFINED ISO_TARGET)
        set(intarget "${ISO_TARGET}")
        set(outtarget "${target}")
    else ()
        set(intarget "${target}")
        set(outtarget "${target}_iso")
    endif ()

    if(NOT TARGET "${intarget}")
        message(FATAL_ERROR "add_iso: target '${intarget}' not defined")
    endif()

    if(DEFINED ISO_OUTPUT)
        get_filename_component(ISO_OUTPUT "${ISO_OUTPUT}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_BINARY_DIR}")
    else()
        set(ISO_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${target}.iso")
    endif()

    if (NOT DEFINED ISO_FS)
        message(FATAL_ERROR "add_iso: FS not specified")
    endif ()

    add_custom_target(${outtarget} ALL
            DEPENDS ${intarget}
            COMMAND "rm" "-Rf" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir"
            COMMAND "mkdir" "-p" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir"
            COMMAND "cp" "-R" "${ISO_FS}/*" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir"
            COMMAND "mkdir" "-p" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir/boot"
            COMMAND "cp" "$<TARGET_FILE:${intarget}>" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir/boot"
            COMMAND "grub-mkrescue" "-o" "${ISO_OUTPUT}" "${CMAKE_CURRENT_BINARY_DIR}/iso_dir"
    )
endfunction()