generating actions
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libzInstalled toString: '${installPrefix}/bin/${libraryFileName}'.
		