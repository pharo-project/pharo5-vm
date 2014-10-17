building
buildMacOSX32 
	
	PharoSOSXConfig new  
		generateForRelease;
		"generateForDebug;"
		addExternalPlugins: #( FT2Plugin );
		generateSources; generate.
