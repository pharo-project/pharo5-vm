building
buildUnix64
	self error: 'Not yet migrated'.
	PharoSpur32UnixConfig new
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
