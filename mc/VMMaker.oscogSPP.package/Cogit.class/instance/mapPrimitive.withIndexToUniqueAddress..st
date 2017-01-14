simulation only
mapPrimitive: primitiveRoutine "<Symbol>" withIndexToUniqueAddress: primitiveIndex "<SmallInteger>"
	| uniqueAddress |
	<doNotGenerate>
	self assert: (primitiveRoutine isSymbol or: [primitiveRoutine isBlock]).
	uniqueAddress := -1 - methodZoneBase - (primitiveIndex * 4) - 16r1000 bitAnd: self allButTopBitOfAddressSpaceMask.
	simulatedTrampolines
		at: uniqueAddress
		ifAbsentPut:
			[primitiveRoutine isSymbol
				ifTrue: [MessageSend receiver: coInterpreter selector: primitiveRoutine]
				ifFalse: [primitiveRoutine]].
	^uniqueAddress