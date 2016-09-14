Author useAuthor: 'LoadVMMaker' during: [ 
	Metacello new
		filetreeDirectory: '../mc';
		baseline: 'Spur';
		load ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].
