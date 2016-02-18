building
buildWin32
	CogSpur32WindowsConfig new  
		"addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( Win32OSProcessPlugin );
		generateSources; 
		generate
