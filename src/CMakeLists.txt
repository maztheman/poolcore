include(poolcore-flags)

set(protobuf_MODULE_COMPATIBLE TRUE)

# Logging library
add_library(loguru STATIC ${CMAKE_CURRENT_SOURCE_DIR}/loguru/loguru.cpp)
poolcore_add_compile_definitions(loguru)
target_link_libraries(loguru PUBLIC poolcore_project_options)

add_subdirectory(blockmaker)
add_subdirectory(poolcommon)
add_subdirectory(poolcore)
add_subdirectory(poolinstances)
