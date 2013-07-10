Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
((Smalltalk at: #ConfigurationOfCog) project version: '6.6') load.

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ]
