building
buildWin32
	PharoSSpur32WindowsConfig new  
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		generateSources; generate.
