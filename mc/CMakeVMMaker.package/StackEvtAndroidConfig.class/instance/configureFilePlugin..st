plugin extra rules
configureFilePlugin: maker
	"extra rules for FilePlugin"

	super configureFilePlugin: maker.  
	
	maker addPlatformSources: #( 'sqAndroidFile.c')