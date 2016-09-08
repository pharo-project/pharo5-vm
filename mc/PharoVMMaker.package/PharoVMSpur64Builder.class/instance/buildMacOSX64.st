building
buildMacOSX64
	"since opensmalltalk-vm, we do not generate CMake anymore, just sources"
	PharoSpur64OSXConfig new  
		topDir: '../opensmalltalk-vm';
		srcDir: '../opensmalltalk-vm/pharo64src';
		addExternalPlugins: #( FT2Plugin EventsHandlerPlugin SDL2DisplayPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources