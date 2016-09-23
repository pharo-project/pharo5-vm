building
buildUnix32
	PharoSpur32UnixConfig new
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spursrc';
		srcPluginsDir: '../opensmalltalk-vm/src';
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin EventsHandlerPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources.
