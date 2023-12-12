# Backend library
add_library(poolcore STATIC
  bitcoinRpcClient.cpp
  ethereumRpcClient.cpp

  accounting.cpp
  backend.cpp
  backendData.cpp
  base58.cpp
  clientDispatcher.cpp
  kvdb.cpp
  poolCore.cpp
  poolInstance.cpp
  priceFetcher.cpp
  rocksdbBase.cpp
  shareLog.cpp
  statistics.cpp
  thread.cpp
  usermgr.cpp
)

poolcore_add_compile_definitions(poolcore)

target_include_directories(poolcore PUBLIC ${rapidjson_SOURCE_DIR}/include  ${CMAKE_CURRENT_SOURCE_DIR}/../include)


target_link_libraries(poolcore
  OpenSSL::SSL
  OpenSSL::Crypto
  rocksdb
  libp2p::all
  Boost::unordered
  poolcore_project_options
)
