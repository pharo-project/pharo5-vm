plugin extra rules
configureUUIDPlugin: maker
	super configureUUIDPlugin: maker.
	maker addFrameworks: #(CoreFoundation).  
	maker addDefinitions: '-x objective-c'.  
	maker addPlatformSources: #('sqMacUUID.c' )