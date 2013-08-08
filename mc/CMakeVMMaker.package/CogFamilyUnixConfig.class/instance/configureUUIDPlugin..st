plugin extra rules
configureUUIDPlugin: maker 
	"extra rules for UUIDPlugin"

	super configureUUIDPlugin: maker.    
	
	maker includeDirectories: '/usr/include/uuid'.
	
	maker addPlatformSources:
		#( 'sqUnixUUID.c')


