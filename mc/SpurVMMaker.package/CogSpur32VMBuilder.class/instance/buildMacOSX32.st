building
buildMacOSX32 

	CogCocoaIOSSpur32Config new 
		generateForRelease;
		"generateForDebug;"
		"addExternalPlugins: #( FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources;
		generate