plugin extra rules
configureMacMenubarPlugin: maker
	maker includeDirectories: '${platformsDir}/iOS/plugins/MacMenubarPlugin'.
	maker 
		addSources: #('MacMenuOS9ToOSX.m') 
		prefixed: '${platformsDir}/iOS/plugins/MacMenubarPlugin/'
