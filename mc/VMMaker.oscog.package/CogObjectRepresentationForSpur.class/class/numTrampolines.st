accessing
numTrampolines
	(initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [ ^ super numTrampolines + 7 ]
		ifFalse: [ ^ super numTrampolines + 6 ]