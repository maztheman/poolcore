cmake_minimum_required(VERSION 3.21)

project(poolcore C CXX)

if(PROJECT_IS_TOP_LEVEL)
    set(CMAKE_CXX_STANDARD 20)
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(CPM)
include(AddSodium)

CPMAddPackage("gh:gflags/gflags#master")
CPMAddPackage(
    NAME rocksdb
    GITHUB_REPOSITORY maztheman/rocksdb
    GIT_TAG main
    OPTIONS
    "WITH_GFLAGS OFF"
    "WITH_ALL_TESTS OFF"
)
CPMAddPackage(
    NAME rapidjson
    GITHUB_REPOSITORY Tencent/rapidjson
    GIT_TAG v1.1.0
    OPTIONS
    "RAPIDJSON_BUILD_TESTS OFF"
    "RAPIDJSON_BUILD_THIRDPARTY_GTEST OFF"
    "RAPIDJSON_BUILD_DOC OFF"
    "RAPIDJSON_BUILD_EXAMPLES OFF"
    "RAPIDJSON_HAS_STDSTRING ON"

)
CPMAddPackage(
    NAME protobuf
    GITHUB_REPOSITORY protocolbuffers/protobuf
    GIT_TAG main
    OPTIONS
    "protobuf_BUILD_TESTS OFF"
    "BUILD_SHARED_LIBS OFF"

)
add_and_build_sodium(poolcore_libsodium)

CPMAddPackage(
    NAME gmp
    URL "https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz"
)
CPMAddPackage("gh:maztheman/libp2p#master")

CPMAddPackage(
    NAME secp256k1
    GITHUB_REPOSITORY bitcoin-core/secp256k1
    GIT_TAG 39198a03eaa33d5902b16d3aefa7c441232f60fb
    DOWNLOAD_ONLY YES
)

CPMAddPackage("gh:boostorg/boost#boost-1.84.0")

execute_process(
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/secp256k1/CMakeLists.txt ${secp256k1_SOURCE_DIR}
)

execute_process(
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/secp256k1/libsecp256k1-config.h.cmake.in ${secp256k1_SOURCE_DIR}/src
)

if(secp256k1_ADDED)
    add_subdirectory(${secp256k1_SOURCE_DIR} ${secp256k1_BINARY_DIR})
endif()

find_package(OpenSSL)

add_library(poolcore_project_options INTERFACE)
target_include_directories(poolcore_project_options INTERFACE
  ${CMAKE_CURRENT_SOURCE_DIR}/src/include
  ${CMAKE_CURRENT_BINARY_DIR}/src
)

add_subdirectory(src)

add_library(poolcore::sodium ALIAS poolcore_libsodium)
add_library(poolcore::core ALIAS poolcore)
add_library(poolcore::common ALIAS poolcommon)
add_library(poolcore::instances ALIAS poolinstances)
add_library(poolcore::blockmaker ALIAS blockmaker)

add_library(poolcore_all INTERFACE)
target_link_libraries(poolcore_all INTERFACE poolcore::sodium poolcore::core poolcore::common poolcore::instances poolcore::blockmaker libp2p::all secp256k1 loguru Boost::unordered)
add_library(poolcore::all ALIAS poolcore_all)
