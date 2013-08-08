plugin extra rules
configureAsynchFilePlugin:  maker 
	"extra rules for AsynchFilePlugin "

	super configureAsynchFilePlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32AsyncFilePrims.c')


