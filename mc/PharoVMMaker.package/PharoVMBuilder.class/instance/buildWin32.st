building
buildWin32
	CogNativeBoostPlugin setTargetPlatform: #Win32PlatformId.

	self buildConfig: (PharoWindowsConfig new  
		addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		addThirdpartyLibrary: 'cairo';
		yourself).
