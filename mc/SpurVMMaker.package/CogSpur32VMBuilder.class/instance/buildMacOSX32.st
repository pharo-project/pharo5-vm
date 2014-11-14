building
buildMacOSX32 
	CogNativeBoostPlugin setTargetPlatform: #Mac32PlatformId.
	CogCocoaIOSSpur32Config new 
		"generateForDebug;"
		"addExternalPlugins: #( FT2Plugin );"
		addInternalPlugins: #( UnixOSProcessPlugin );
		generateSources;
		generate