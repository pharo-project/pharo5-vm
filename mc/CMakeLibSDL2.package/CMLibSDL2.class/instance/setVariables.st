as yet unclassified
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
	 	set: #libSDL2Installed toString: '${installPrefix}/lib/${libraryFileName}'