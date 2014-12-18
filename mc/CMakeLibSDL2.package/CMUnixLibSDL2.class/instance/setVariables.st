generating actions
setVariables
	super setVariables.
	gen 
	 	set: #libraryLinkFileName to: self libraryLinkFileName;	
		set: #libSDL2LinkInstalled toString: '${installPrefix}/lib/${libraryLinkFileName}'	