building
buildMacOSX32 
	"Build with freetype, cairo, osprocess"
	CogNativeBoostPlugin setTargetPlatform: #Mac32PlatformId.
	
	PharoOSXConfig new  
		generateForRelease;
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo' 
			"'libsdl2'" 
			'libgit2'
			'libssh2');
		generateSources; 
		generate.
