building
buildMacOSX32 
	PharoSSpur32OSXConfig new  
		generateForRelease;
		"generateForDebug;"
		"addExternalPlugins: #(  FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources; 
		generate.
