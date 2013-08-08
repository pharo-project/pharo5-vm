plugin extra rules
configureHostWindowPlugin: maker
	super configureHostWindowPlugin: maker.
	maker 
		addSources: #('sqMacHostWindow.m' ) 
		prefixed: '${platformsDir}/iOS/vm/OSX/plugins/HostWindowPlugin/'
