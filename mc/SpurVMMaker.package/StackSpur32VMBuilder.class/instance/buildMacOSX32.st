building
buildMacOSX32 

	StackSpur32OSXConfig new 
		generateForRelease;
		"generateForDebug;"
		"addExternalPlugins: #( FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources;
		generate