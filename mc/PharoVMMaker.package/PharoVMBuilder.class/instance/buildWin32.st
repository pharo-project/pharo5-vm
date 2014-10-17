building
buildWin32
	CogNativeBoostPlugin setTargetPlatform: #Win32PlatformId.

	PharoWindowsConfig new  
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
