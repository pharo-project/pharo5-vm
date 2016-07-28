building
buildMacOSX32 
	"since opensmalltalk-vm, we do not generate CMake anymore, just sources"
	PharoSSpur32OSXConfig new  
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spurstacksrc';
		addExternalPlugins: #( FT2Plugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources.
