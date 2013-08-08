plugin extra rules
configureSqueakSSLPlugin: maker 
	"extra rules for SqueakSSLPlugin"
	
	maker addPlatformSources: #( 'sqUnixOpenSSL.c').
	
	maker addExternalLibraries: #('ssl' ).
	