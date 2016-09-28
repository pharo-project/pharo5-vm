building
buildUnix64
	PharoSpur64UnixConfig new
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spur64src';
		srcPluginsDir: '../opensmalltalk-vm/src';
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin EventsHandlerPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources.
