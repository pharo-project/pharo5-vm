building
buildUnix32
	CogSpur32UnixConfig new
		"addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; 
		generate
