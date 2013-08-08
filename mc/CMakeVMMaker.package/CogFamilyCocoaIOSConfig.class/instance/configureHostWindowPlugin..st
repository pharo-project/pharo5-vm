plugin extra rules
configureHostWindowPlugin: maker
	super configureHostWindowPlugin: maker.
	maker includeDirectories: '${platformsDir}/Cross/plugins/HostWindowPlugin'.