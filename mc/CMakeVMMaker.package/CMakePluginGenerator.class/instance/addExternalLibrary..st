cmake commands
addExternalLibrary: aLibrary 
	self isInternal 
		ifTrue: [ vmGen addExternalLibrary: aLibrary ]
		ifFalse: [ super addExternalLibrary: aLibrary ].