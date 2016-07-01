Author useAuthor: 'LoadVMMaker' during: [ 
	Metacello new
		baseline: 'Spur';
		repository: 'github://pharo-project/pharo-vm:spur64/mc';
		load ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].
