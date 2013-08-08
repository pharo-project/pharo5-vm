plugin extra rules
configureInternetConfigPlugin: maker
	super configureInternetConfigPlugin: maker.
	maker addPlatformSources: #( 'sqUnixInternetConfiguration' )