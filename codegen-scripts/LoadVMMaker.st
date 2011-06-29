
Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
((Smalltalk at: #ConfigurationOfCog) project
	version: '2.2') load.

(Smalltalk saveAs: 'generator.image') ifFalse: [
				 Smalltalk snapshot: false andQuit: true]
