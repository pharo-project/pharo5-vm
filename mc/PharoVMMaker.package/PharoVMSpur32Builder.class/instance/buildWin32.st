building
buildWin32
	PharoSpur32WindowsConfig new  
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.