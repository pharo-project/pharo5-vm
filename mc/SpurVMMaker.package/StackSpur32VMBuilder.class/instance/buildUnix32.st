building
buildUnix32

	StackSpur32UnixConfig new
		"addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );"
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; 
		generate
