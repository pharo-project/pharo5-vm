building
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.
	PharoSpur32UnixConfig new
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		"addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2'
			'libsdl2');"
		generateSources; 
		generate.
