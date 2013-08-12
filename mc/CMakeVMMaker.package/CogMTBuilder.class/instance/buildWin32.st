building
buildWin32

	CogMTWindowsConfig new  

		addExternalPlugins: #(  FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		
		generateSources; generate.
