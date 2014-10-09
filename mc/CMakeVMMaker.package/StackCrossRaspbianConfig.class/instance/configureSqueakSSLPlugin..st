as yet unclassified
configureSqueakSSLPlugin: maker 
	"extra rules for SqueakSSLPlugin"
	"maker linkDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/'."
	super configureSqueakSSLPlugin: maker .