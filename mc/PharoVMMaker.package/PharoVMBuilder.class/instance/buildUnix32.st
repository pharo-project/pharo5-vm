building
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.

	
	PharoUnixConfig new
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; generate.
