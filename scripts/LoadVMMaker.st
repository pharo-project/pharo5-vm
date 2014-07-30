Author useAuthor: 'LoadVMMaker' during: [ 
	Gofer new
		url: 'filetree://../mc';
		package: 'ConfigurationOfSpur';
		load.	
	(Smalltalk at: #ConfigurationOfSpur) loadGit ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].
