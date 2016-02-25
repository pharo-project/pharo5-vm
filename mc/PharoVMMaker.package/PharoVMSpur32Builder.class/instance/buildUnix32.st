building
buildUnix32
	PharoSpur32UnixConfig new
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		addThirdpartyLibraries: #( 
			'libssh2' 
			'libgit2'
			'libsdl2');
		generateSources; 
		generate.
