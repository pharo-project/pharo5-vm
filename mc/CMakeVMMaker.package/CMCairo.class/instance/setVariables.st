generating actions
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libcairoInstalled toString: '${installPrefix}/lib/${libraryFileName}'.
		