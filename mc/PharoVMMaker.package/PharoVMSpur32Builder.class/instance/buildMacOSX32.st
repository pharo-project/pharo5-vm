building
buildMacOSX32 
	"since opensmalltalk-vm, we do not generate CMake anymore, just sources"
	PharoSpur32OSXConfig new  
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/spursrc';
		srcPluginsDir: '../opensmalltalk-vm/src';
		addExternalPlugins: #( FT2Plugin EventsHandlerPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources
