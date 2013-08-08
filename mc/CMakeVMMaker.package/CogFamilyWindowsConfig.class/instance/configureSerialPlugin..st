plugin extra rules
configureSerialPlugin:     maker 
	"extra rules for SerialPlugin "

	super configureSerialPlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32SerialPort.c')


