generating actions
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
	 	set: #libGit2Installed toString: '${installPrefix}/lib/${libraryFileName}'