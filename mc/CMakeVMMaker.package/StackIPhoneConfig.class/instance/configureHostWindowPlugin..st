plugin extra rules
configureHostWindowPlugin: maker
	maker includeDirectories: '${platformsDir}/Cross/plugins/HostWindowPlugin'.	
	maker 
		addSources: #('sqMacHostWindow.m' ) 
		prefixed: '${platformsDir}/iOS/vm/iPhone/plugins/HostWindowPlugin/'
