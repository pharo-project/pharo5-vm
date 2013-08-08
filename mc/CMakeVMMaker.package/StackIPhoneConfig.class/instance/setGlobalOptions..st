settings
setGlobalOptions: maker
	"set any CMake global options, before declaring a project in cmake file"
	
"	maker 
		set: 'CMAKE_C_COMPILER' 
		to: ('/Applications/Xcode.app/Contents/Developer/Platforms/{target}.platform/Developer/usr/bin/gcc'
			nameFormat: {'target' -> self targetDevice} asDictionary).
	maker 
		set: 'CMAKE_CXX_COMPILER' 
		to: ('/Applications/Xcode.app/Contents/Developer/Platforms/{target}.platform/Developer/usr/bin/g++'
			nameFormat: {'target' -> self targetDevice } asDictionary).	
	self architecture ifNotNil: [
		maker set: 'CMAKE_OSX_ARCHITECTURES' to: self architecture ]."
	