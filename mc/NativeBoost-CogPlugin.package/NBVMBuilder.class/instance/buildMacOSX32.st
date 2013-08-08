as yet unclassified
buildMacOSX32 
	"Build with freetype, cairo, osprocess"
	CogNativeBoostPlugin setTargetPlatform: #Mac32PlatformId.
	
	NBCogCocoaIOSConfig new  
		generateForRelease;
		addExternalPlugins: #(  FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		addThirdpartyLibrary: 'cairo';

		generateSources; generate.
