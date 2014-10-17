building
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.
	
	PharoUnixConfig new
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
