plugin extra rules
configureHostWindowPlugin: maker
	"extra rules for HostWindowPlugin"

	super configureHostWindowPlugin: maker.  
	maker addPlatformSources: #( 'sqMacHostWindow.c' )
