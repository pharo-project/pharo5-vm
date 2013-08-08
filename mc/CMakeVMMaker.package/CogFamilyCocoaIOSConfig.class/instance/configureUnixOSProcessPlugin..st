plugin extra rules
configureUnixOSProcessPlugin: maker
	super configureHostWindowPlugin: maker.
	maker includeDirectories: '${platformsDir}/Cross/plugins/SocketPlugin'.