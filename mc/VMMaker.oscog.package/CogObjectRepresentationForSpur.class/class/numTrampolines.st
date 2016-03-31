accessing
numTrampolines
	(initializationOptions at: #IMMUTABILITY ifAbsent: [false])
		ifTrue: [ ^ super numTrampolines + self new numStoreTrampolines + 7 ]
		ifFalse: [ ^ super numTrampolines + 6 ]