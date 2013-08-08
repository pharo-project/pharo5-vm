span functions
v3or4PushNilSize: aMethodObj
	^(coInterpreter methodUsesAlternateBytecodeSet: aMethodObj)
		ifTrue: [self v4PushNilSize: aMethodObj]
		ifFalse: [self v3PushNilSize: aMethodObj]