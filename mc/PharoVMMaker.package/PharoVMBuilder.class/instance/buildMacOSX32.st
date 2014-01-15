building
buildMacOSX32 
	"Build with freetype, cairo, osprocess"
	CogNativeBoostPlugin setTargetPlatform: #Mac32PlatformId.
	
	PharoOSXConfig new  
		generateForRelease;
		"generateForDebug;"
		addExternalPlugins: #(  FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		addThirdpartyLibrary: 'cairo';
		generateSources; generate.
