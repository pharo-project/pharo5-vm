as yet unclassified
setVariables
	super setVariables.
	gen 
		"for some reason, windows believes a dll is an executable"
	 	set: #libSDL2Installed toString: '${installPrefix}/bin/${libraryFileName}'