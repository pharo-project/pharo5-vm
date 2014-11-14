building
buildUnix32
	CogNativeBoostPlugin  setTargetPlatform: #Linux32PlatformId.
	CogSpur32UnixConfig new
		"addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; 
		generate
