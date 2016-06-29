Author useAuthor: 'LoadVMMaker' during: [ 
	Metacello new
		baseline: 'Spur';
		repository: 'github://pharo-project/pharo-vm:master/mc';
		load ].

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].
