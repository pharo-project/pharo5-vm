building
buildMacOSX32 
	"Build with freetype, cairo, osprocess"
	CogNativeBoostPlugin setTargetPlatform: #Mac32PlatformId.
	PharoSpur32OSXConfig new  
		generationType: generationType;
		addExternalPlugins: #( FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		addThirdpartyLibraries: #(
			'cairo' 
			'libgit2'
			'libssh2'
			'libsdl2');
		generateSources; 
		generate.
