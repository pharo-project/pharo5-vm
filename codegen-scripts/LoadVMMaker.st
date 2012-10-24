Gofer new
	squeaksource: 'PharoVM';
	package: 'ConfigurationOfPharoVM';
	load.

((Smalltalk at: #ConfigurationOfPharoVM) project version: '2.0-6') load.

(Smalltalk saveAs: 'generator.image') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ]
