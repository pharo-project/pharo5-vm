Gofer new
	squeaksource: 'PharoVM';
	package: 'ConfigurationOfPharoVM';
	load.
	
((Smalltalk at: #ConfigurationOfPharoVM) project version: '1.4-1') load.

(Smalltalk saveAs: 'generator.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]
