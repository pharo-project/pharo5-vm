generating actions
setVariables
	super setVariables.
	gen 
	 	set: #libraryFileName to: self libraryFileName;			
		set: #libSDL2Installed toString: '${installPrefix}/bin/${libraryFileName}'