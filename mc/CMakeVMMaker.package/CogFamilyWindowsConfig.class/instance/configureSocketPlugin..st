plugin extra rules
configureSocketPlugin:  maker 
	"extra rules for SocketPlugin "

	super configureSocketPlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32NewNet.c')


