plugin extra rules
configureCroquetPlugin:  maker 
	"extra rules for CroquetPlugin "

	super configureCroquetPlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32CroquetPlugin.c')


