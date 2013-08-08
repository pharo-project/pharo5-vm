as yet unclassified
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.

	
	NBCogUnixConfig new
		addExternalPlugins: #( FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources; generate.
