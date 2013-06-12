Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
((Smalltalk at: #ConfigurationOfCog) project version: '6.4') load.

(Smalltalk saveAs: 'generator.image') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ]
