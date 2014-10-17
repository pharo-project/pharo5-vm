building
buildFreeBSD32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.
	
	PharoFreeBSDConfig new
		"generateForDebug;"
		addExternalPlugins: #( SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2' );
		generateSources; 
		generate.
