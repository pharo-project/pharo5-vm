building
buildWin32

	StackSpur32WindowsConfig new  
		"addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( Win32OSProcessPlugin );
		generateSources; 
		generate
