plugin extra rules
configureJoystickTabletPlugin: maker 
	"extra rules for JoystickTabletPlugin"
	
	super configureJoystickTabletPlugin: maker.  
	maker addPlatformSources:
		#( 'sqAndroidJoystickTablet.c' )
