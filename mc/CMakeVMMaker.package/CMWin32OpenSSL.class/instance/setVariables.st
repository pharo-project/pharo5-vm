as yet unclassified
setVariables 
	super setVariables.
	
	gen
		set: #libraryFileName to: self libraryFileName;
		set: #libInstalled to: '${installPrefix}/lib/${libraryFileName}'