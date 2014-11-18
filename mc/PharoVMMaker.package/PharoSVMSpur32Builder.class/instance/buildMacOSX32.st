building
buildMacOSX32 
	PharoSSpur32OSXConfig new  
		generateForDebug;
		"addExternalPlugins: #(  FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources; 
		generate.
