generating actions
setVariables
	super setVariables.
	
"add include path"
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libpngInstalled toString: '${installPrefix}/lib/${libraryFileName}'.
		