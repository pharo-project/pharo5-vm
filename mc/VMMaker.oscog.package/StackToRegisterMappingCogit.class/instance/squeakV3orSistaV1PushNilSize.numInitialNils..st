span functions
squeakV3orSistaV1PushNilSize: aMethodObj numInitialNils: numInitialNils
	^(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue: [self sistaV1PushNilSize: aMethodObj numInitialNils: numInitialNils]
		ifFalse: [self v3PushNilSize: aMethodObj numInitialNils: numInitialNils]