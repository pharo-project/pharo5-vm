as yet unclassified
configureB3DAcceleratorPlugin: maker
	"extra rules for B3DAcceleratorPlugin"
	
	super configureB3DAcceleratorPlugin: maker.
	maker includeDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/include/'.