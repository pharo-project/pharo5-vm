building
buildWin32
	(Smalltalk at: #CogNativeBoostPlugin) setTargetPlatform: #Win32PlatformId.

	PharoWindowsConfig new  
		addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
