Gofer new
	squeaksource: 'MetacelloRepository';
	squeaksource: 'PharoVM';
	package: 'ConfigurationOfCog';
	package: 'ConfigurationOfPharoVM';
	load.
	
((Smalltalk at: #ConfigurationOfCog) project version: #bleedingEdge) load.
((Smalltalk at: #ConfigurationOfPharoVM) project version: #bleedingEdge) load: #('PharoVMMaker').

(Smalltalk saveAs: 'generator.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]