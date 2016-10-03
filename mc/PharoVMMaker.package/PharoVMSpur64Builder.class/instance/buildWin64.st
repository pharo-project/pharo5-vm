building
buildWin64
	self error: 'Not yet migrated'.
	self flag: #todo. "SDL2DisplayPlugin is temporary made internal, I need to figure out 
	why ot does not link with an unreferenced symbol if I build it as external." 
	PharoSpur64WindowsConfig new  
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spur64src';
		srcPluginsDir: '../opensmalltalk-vm/src';
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin EventsHandlerPlugin );
		addInternalPlugins: #( Win32OSProcessPlugin SDL2DisplayPlugin );
		generateSources.