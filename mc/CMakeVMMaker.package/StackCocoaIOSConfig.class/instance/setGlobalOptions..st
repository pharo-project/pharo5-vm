settings
setGlobalOptions: maker
   super setGlobalOptions: maker.
   maker set: 'CMAKE_C_COMPILER' to: 'clang'.
   maker set: 'CMAKE_CXX_COMPILER' to: 'clang++'.