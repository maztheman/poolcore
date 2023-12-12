function(poolcore_add_compile_definitions THE_TARGET)

if(MSVC)
  target_compile_definitions(
    ${THE_TARGET}
    PRIVATE
    -D_CRT_SECURE_NO_DEPRECATE
    -D_CRT_SECURE_NO_WARNINGS
    -D_CRT_NONSTDC_NO_DEPRECATE
    -D__STDC_LIMIT_MACROS
    -D__STDC_FORMAT_MACROS
    -DNOMINMAX
    -DNOGDI
  )

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /GR-" PARENT_SCOPE)
  target_include_directories(${THE_TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/msvc/include)
else(MSVC)
  set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra" PARENT_SCOPE)
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra" PARENT_SCOPE)
  if (CXXPM_SYSTEM_PROCESSOR STREQUAL "x86_64")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcx16" PARENT_SCOPE)
  endif()
endif(MSVC)

if (SANITIZER_ENABLED)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address" PARENT_SCOPE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address" PARENT_SCOPE)
endif()

endfunction()