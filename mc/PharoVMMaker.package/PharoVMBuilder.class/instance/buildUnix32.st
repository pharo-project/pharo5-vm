building
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.
	
	PharoUnixConfig new
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2' );
		generateSources; 
		generate.
