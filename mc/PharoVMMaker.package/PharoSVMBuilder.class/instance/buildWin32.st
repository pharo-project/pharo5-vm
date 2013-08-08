building
buildWin32

	PharoSWindowsConfig new  
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		generateSources; generate.
