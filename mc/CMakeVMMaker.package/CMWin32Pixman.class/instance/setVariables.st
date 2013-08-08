as yet unclassified
setVariables
	super setVariables.
	
"add include path"
	gen 
		set: #libraryFileName to: self libraryFileName;
		set: #libpixmanInstalled toString: '${installPrefix}/bin/${libraryFileName}'.
		