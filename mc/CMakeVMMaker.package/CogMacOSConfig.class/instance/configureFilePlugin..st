plugin extra rules
configureFilePlugin: maker
	"extra rules for FilePlugin"

	super configureFilePlugin: maker.  
	
	maker includeDirectories: '${platformsDir}/unix/vm'.
	maker addPlatformSources: #( 'sqMacUnixFileInterface.c' 'sqMacDirectory.c')