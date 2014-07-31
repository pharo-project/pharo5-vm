span functions
squeakV3orSistaV1PushNilSize: aMethodObj
	^(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue: [self sistaV1PushNilSize: aMethodObj]
		ifFalse: [self v3PushNilSize: aMethodObj]