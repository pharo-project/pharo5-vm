plugin extra rules
configureQuicktimePlugin: maker
	
	maker includeDirectories: '${pluginPlatform}'.
	maker includeDirectories: '${crossDir}/plugins/SurfacePlugin'.
	
	" yes, this is not a typo , a file is named 'inteface' instead of 'interface' "

	maker addPlatformSources: #( 'sqMacQuicktimeInteface.c' ).
	
	maker addFrameworks: #( 'Carbon' 'QuickTime' ).