generating actions
copyArtefacts
	super copyArtefacts.
	self 
		copy: '${SDL2LibInstalled}' 
		to: '${externalModulesDir}/libSDL2-2.0.so.0'.