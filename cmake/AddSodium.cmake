include(CPM)

function(add_and_build_sodium TARGET_INTERFACE)

CPMAddPackage(
  NAME sodium
  GITHUB_REPOSITORY jedisct1/libsodium
  GIT_TAG master
)

find_program(MAKE_EXECUTABLE make)
find_program(SH_EXECUTABLE sh)
find_program(PWD_EXECUTABLE pwd)

execute_process(
  COMMAND ${PWD_EXECUTABLE}
  COMMAND_ECHO STDOUT
  WORKING_DIRECTORY ${sodium_SOURCE_DIR}
)

execute_process(
  COMMAND "${sodium_SOURCE_DIR}/autogen.sh" "-s"
  COMMAND_ECHO STDOUT
  WORKING_DIRECTORY ${sodium_SOURCE_DIR}
)

execute_process(
  COMMAND "${sodium_SOURCE_DIR}/configure" --prefix=${sodium_BINARY_DIR}
  COMMAND_ECHO STDOUT
  WORKING_DIRECTORY ${sodium_SOURCE_DIR}
)

execute_process(
  COMMAND ${MAKE_EXECUTABLE}
  COMMAND_ECHO STDOUT
  WORKING_DIRECTORY ${sodium_SOURCE_DIR}
)

execute_process(
  COMMAND ${MAKE_EXECUTABLE} install
  COMMAND_ECHO STDOUT
  WORKING_DIRECTORY ${sodium_SOURCE_DIR}
)

add_library(${TARGET_INTERFACE} INTERFACE)

target_include_directories(${TARGET_INTERFACE} INTERFACE ${sodium_BINARY_DIR}/include)
target_link_directories(${TARGET_INTERFACE} INTERFACE ${sodium_BINARY_DIR}/lib)

endfunction()