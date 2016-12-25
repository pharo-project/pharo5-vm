compaction
methodHeaderFromSavedFirstField: field
	(self isIntegerObject: field) ifTrue:
		[^field].
	self assert: ((self isNonImmediate: field) and: [field < newSpaceStart]).
	self assert: (coInterpreter cCoerceSimple: field to: #'CogMethod *') objectHeader
				= self nullHeaderForMachineCodeMethod.
	^(coInterpreter cCoerceSimple: field to: #'CogMethod *') methodHeader