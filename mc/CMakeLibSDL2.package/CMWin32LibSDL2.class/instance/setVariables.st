generating actions
setVariables
	super setVariables.
	gen 
	 	set: #libSDL2BinaryInstalled toString: '${installPrefix}/bin/${libraryFileName}'