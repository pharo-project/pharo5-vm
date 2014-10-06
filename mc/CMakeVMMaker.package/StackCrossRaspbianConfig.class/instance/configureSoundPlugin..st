as yet unclassified
configureSoundPlugin: maker 
	"extra rules for SoundPlugin"
		maker linkDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/'.
	super configureSoundPlugin: maker 
