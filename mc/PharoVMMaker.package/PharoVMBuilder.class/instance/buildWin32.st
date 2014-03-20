building
buildWin32
	CogNativeBoostPlugin setTargetPlatform: #Win32PlatformId.

	PharoWindowsConfig new  
		addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2');
		generateSources; 
		generate.
