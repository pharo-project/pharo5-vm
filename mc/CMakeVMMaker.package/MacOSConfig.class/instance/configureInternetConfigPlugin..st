plugin extra rules
configureInternetConfigPlugin: maker
	"extra rules for InternetConfigPlugin"
	
	super configureInternetConfigPlugin: maker.  
	maker addPlatformSources: #( 'sqMacInternetConfiguration.c')
