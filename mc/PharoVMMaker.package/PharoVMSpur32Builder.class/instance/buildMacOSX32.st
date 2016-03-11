building
buildMacOSX32 
	PharoSpur32OSXConfig new  
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo' 
			'libgit2'
			'libssh2'
			'libsdl2');
		generateSources; 
		generate.
