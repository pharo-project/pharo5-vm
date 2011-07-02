Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
[ ((Smalltalk at: #ConfigurationOfCog) project version: #bleedingEdge) load ]
on: Warning do: [ :e | e resume ].
	
(Smalltalk saveAs: 'generator.image') 
	ifFalse: [ Smalltalk snapshot: false andQuit: true ]
