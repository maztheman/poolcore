add_library(poolcommon STATIC
  arith_uint256.cpp
  bech32.cpp
  bigNum.cpp
  coroutineJoin.cpp
  file.cpp
  taskHandler.cpp
  totp.cpp
  uint256.cpp
  utils.cpp
)

poolcore_add_compile_definitions(poolcommon)

target_link_libraries(poolcommon
  OpenSSL::SSL
  OpenSSL::Crypto
  libp2p::all
  poolcore_project_options
  ${BIGNUM_LIBRARIES}
)
