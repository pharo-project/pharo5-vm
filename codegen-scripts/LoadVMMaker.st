Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
<<<<<<< HEAD
((Smalltalk at: #ConfigurationOfCog) project version: #bleedingEdge) load.
=======
((Smalltalk at: #ConfigurationOfCog) project version: '3.1') load.
>>>>>>> fe0330a267e1a99bd27bd161443c5cc255fde8c3

(Smalltalk saveAs: 'generator.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]
