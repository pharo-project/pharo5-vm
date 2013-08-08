plugin extra rules
configureSecurityPlugin: maker 
	"extra rules for MIDIPlugin"

	super configureSecurityPlugin: maker.
	
	maker addPlatformSources: #( 'sqAndroidSecurity.c')