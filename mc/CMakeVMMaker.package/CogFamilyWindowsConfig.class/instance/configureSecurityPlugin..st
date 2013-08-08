plugin extra rules
configureSecurityPlugin: maker 
	"extra rules for SecurityPlugin"

	super configureSecurityPlugin: maker.
	
	maker addPlatformSources: #( 'sqWin32Security')


