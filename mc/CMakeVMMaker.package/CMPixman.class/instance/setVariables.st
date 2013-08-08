generating actions
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libpixmanInstalled toString: '${installPrefix}/lib/${libraryFileName}'.
		
	