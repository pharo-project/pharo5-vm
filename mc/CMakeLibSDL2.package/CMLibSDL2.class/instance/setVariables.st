as yet unclassified
setVariables
	super setVariables.
	gen 
		set: #SDL2_includeDir toString: '${installPrefix}/include';
		set: #libraryFileName to: self libraryFileName;
		set: #SDL2_includeDir toString: '${installPrefix}/include';
	 	set: #SDL2LibInstalled toString: '${installPrefix}/lib/${libraryFileName}'