generating actions
setVariables
	super setVariables.
	gen 
		"for some reason, windows believes a dll is an executable"
	 	set: #libGit2Installed toString: '${installPrefix}/bin/${libraryFileName}'