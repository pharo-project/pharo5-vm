building
buildMacOSX32 
	CogSpur32OSXConfig new 
		"generateForDebug;"
		"addExternalPlugins: #( FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources;
		generate