as yet unclassified
buildWin32
	CogNativeBoostPlugin setTargetPlatform: #Win32PlatformId.

	NBCogWindowsConfig new  

		addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		addThirdpartyLibrary: 'cairo';
		
		generateSources; generate.
