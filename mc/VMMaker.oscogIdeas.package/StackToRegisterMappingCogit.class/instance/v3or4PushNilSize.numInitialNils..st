span functions
v3or4PushNilSize: aMethodObj numInitialNils: numInitialNils
	^(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue: [self v4PushNilSize: aMethodObj numInitialNils: numInitialNils]
		ifFalse: [self v3PushNilSize: aMethodObj numInitialNils: numInitialNils]