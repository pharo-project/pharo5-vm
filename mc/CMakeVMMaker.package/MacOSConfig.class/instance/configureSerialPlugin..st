plugin extra rules
configureSerialPlugin: maker 
	"extra rules for SerialPlugin"

	super configureSoundPlugin: maker.  
	maker includeDirectories: '${platformsDir}/unix/plugins/SerialPlugin'.
	maker 
		addSources: #('sqUnixSerial.c') 
		prefixed: '${platformsDir}/unix/plugins/SerialPlugin/'


