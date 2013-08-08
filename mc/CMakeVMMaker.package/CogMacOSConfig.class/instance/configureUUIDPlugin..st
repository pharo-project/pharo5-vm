plugin extra rules
configureUUIDPlugin: maker 
	"extra rules for UUIDPlugin"

	super configureUUIDPlugin: maker.    
	maker addPlatformSources:
		#( 'sqMacUUID.c')


