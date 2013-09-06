building
buildUnix32
	CogNativeBoostPlugin setTargetPlatform: #Linux32PlatformId.

	
	self buildConfig: (PharoUnixConfig new
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		yourself).
