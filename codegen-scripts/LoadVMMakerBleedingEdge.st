Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
((Smalltalk at: #ConfigurationOfCog) project version: #bleedingEdge) load.

Gofer new
	squeaksource: 'PharoVM';
	package: 'ConfigurationOfPharoVM';
	load.
((Smalltalk at: #ConfigurationOfPharoVM) project version: #bleedingEdge) load.

(Smalltalk saveAs: 'generator.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]
