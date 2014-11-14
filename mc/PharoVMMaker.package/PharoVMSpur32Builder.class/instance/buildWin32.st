building
buildWin32
	CogNativeBoostPlugin setTargetPlatform: #Win32PlatformId.
	PharoSpur32WindowsConfig new  
		"addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( Win32OSProcessPlugin );
		"addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2'
			'libsdl2');"
		generateSources; 
		generate.
