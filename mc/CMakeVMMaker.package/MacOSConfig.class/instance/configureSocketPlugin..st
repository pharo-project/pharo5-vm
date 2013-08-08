plugin extra rules
configureSocketPlugin: maker 
	"extra rules for SoundPlugin"

	super configureSoundPlugin: maker.  
	maker includeDirectories: '${platformsDir}/unix/plugins/SocketPlugin'.
	maker 
		addSources: #('sqUnixSocket.c') 
		prefixed: '${platformsDir}/unix/plugins/SocketPlugin/'


