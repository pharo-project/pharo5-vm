as yet unclassified
setVariables
	super setVariables.
	gen 
	 	set: #SDL2BinInstalled toString: '${installPrefix}/bin/SDL2.dll'