building
buildUnix32
	(Smalltalk at: #CogNativeBoostPlugin) setTargetPlatform: #Linux32PlatformId.
	
	PharoUnixConfig new
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
