plugin extra rules
configureDropPlugin:  maker 
	"extra rules for DropPlugin "

	super configureDropPlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32Drop')


