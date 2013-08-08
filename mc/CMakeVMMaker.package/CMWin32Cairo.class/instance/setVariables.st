as yet unclassified
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libcairoInstalled toString: '${installPrefix}/bin/${libraryFileName}'.
		