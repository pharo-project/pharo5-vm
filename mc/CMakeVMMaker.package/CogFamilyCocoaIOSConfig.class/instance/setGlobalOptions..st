settings
setGlobalOptions: maker

	"set any CMake global options, before declaring a project in cmake file"
	
	maker set: 'CMAKE_C_COMPILER' to: '/usr/bin/gcc'.
	maker set: 'CMAKE_CXX_COMPILER' to: '/usr/bin/g++'.