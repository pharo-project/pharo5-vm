building
buildUnix32

	PharoSUnixConfig new
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		generateSources; generate.
