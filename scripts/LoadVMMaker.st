Author useAuthor: 'LoadVMMaker' during: [ 
	Metacello new
		baseline: 'Spur';
		repository: 'filetree://../mc';
		load ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].
