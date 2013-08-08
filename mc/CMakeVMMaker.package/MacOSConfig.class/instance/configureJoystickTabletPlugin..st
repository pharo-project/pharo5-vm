plugin extra rules
configureJoystickTabletPlugin: maker 
	"extra rules for JoystickTabletPlugin"
	
	super configureJoystickTabletPlugin: maker.  
	maker addPlatformSources:
		#( 
			'HID_Error_Handler.c'
			'HID_Name_Lookup.c'
			'HID_Queue_Utilities.c'
			'HID_Utilities.c'
			'sqMacJoystickAndTablet.c'
			)
