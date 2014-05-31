as yet unclassified
copyArtefacts
	super copyArtefacts.
	self 
		copy: '${libSDL2Installed}' 
		to: '${externalModulesDir}/libSDL2-2.0.so.0'.