add_library(poolinstances STATIC
  fabric.cpp
  protocol.proto
)

poolcore_add_compile_definitions(poolinstances)

target_include_directories(poolinstances PUBLIC ${RAPIDJSON_INCLUDE_DIRECTORY} ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(poolinstances PUBLIC
  Boost::unordered
  OpenSSL::SSL
  OpenSSL::Crypto
  rocksdb
  libp2p::all
  protobuf::libprotobuf
  poolcore_project_options
  ${BIGNUM_LIBRARIES}
)

include(${protobuf_BINARY_DIR}/cmake/protobuf/protobuf-generate.cmake)

protobuf_generate(TARGET poolinstances)

if (MSVC)
  set_source_files_properties("protocol.pb.cc" PROPERTIES COMPILE_FLAGS "/wd4244 /wd4267")
endif()
