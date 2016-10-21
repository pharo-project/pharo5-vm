building
buildWin32
	PharoSpur32WindowsConfig new
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spursrc';
		srcPluginsDir: '../opensmalltalk-vm/src';
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin EventsHandlerPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin );
		"addThirdpartyLibraries: #('cairo' 'libssh2' 'libgit2' 'libsdl2');"
		generateSources