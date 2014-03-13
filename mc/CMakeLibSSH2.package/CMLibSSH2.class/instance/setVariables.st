generating actions
setVariables
	super setVariables.
	gen 
		set: #libraryFileName to: self libraryFileName;
	 	set: #libSSH2Installed toString: '${installPrefix}/lib/${libraryFileName}'