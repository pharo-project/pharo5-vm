building
buildWin32
	self flag: #todo. "SDL2DisplayPlugin is temporary made internal, I need to figure out 
	why ot does not link with an unreferenced symbol if I build it as external." 
	PharoSpur32WindowsConfig new  
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin SDL2DisplayPlugin );
		addThirdpartyLibraries: #(
			'cairo'
			'libssh2'
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.