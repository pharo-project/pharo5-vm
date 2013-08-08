plugin extra rules
configureSqueakSSLPlugin: maker
	| lib |
	maker addPlatformSources: #('sqUnixOpenSSL.c').
	
	lib := self addThirdpartyLibrary: 'openssl'.

	maker includeDirectories: lib includeDir.
	maker linkDirectories: '${outputDir}'.
	
	maker addExternalLibraries: 
		#( 
			'libeay32.dll' 
			'ssleay32.dll'
		).
		
	maker addDependency: lib buildTarget
