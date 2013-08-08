plugin extra rules
configureSystemInfoPlugin: maker
	maker includeDirectories: '${platformsDir}/Cross/plugins/SystemInfoPlugin'.
	maker addPlatformSources: #('sqSystemInfo.m' ).