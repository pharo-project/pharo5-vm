Author useAuthor: 'LoadVMMaker' during: [ 
	Gofer new
		url: 'filetree://../mc';
		package: 'ConfigurationOfCog';
		load.	
	(Smalltalk at: #ConfigurationOfCog) loadGit ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].