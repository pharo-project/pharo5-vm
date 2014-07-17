building
buildMacOSX32 

	StackCocoaIOSSpur32Config new 
		generateForRelease;
		"generateForDebug;"
		"addExternalPlugins: #( FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources;
		generate