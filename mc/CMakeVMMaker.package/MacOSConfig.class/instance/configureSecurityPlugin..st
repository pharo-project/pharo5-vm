plugin extra rules
configureSecurityPlugin: maker 
	"extra rules for SecurityPlugin"

	super configureSecurityPlugin: maker.  
	maker includeDirectories: '${crossDir}/plugins/FilePlugin'.
	maker addPlatformSources: #( 'sqMacSecurity.c' )