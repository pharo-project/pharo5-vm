bytecode generators
extendedStoreAndPopBytecode
	| variableType variableIndex |
	variableType := byte1 >> 6 bitAnd: 3.
	variableIndex := byte1 bitAnd: 63.
	variableType = 0 ifTrue:
		[^self genStorePop: true ReceiverVariable: variableIndex].
	variableType = 1 ifTrue:
		[self genStorePop: true TemporaryVariable: variableIndex.
		"needs a fake map entry if Immutability is ON..."
		self cppIf: IMMUTABILITY ifTrue: [ self annotateBytecode: self Label. ].
		^ 0].
	variableType = 3 ifTrue:
		[^self genStorePop: true LiteralVariable: variableIndex].
	^EncounteredUnknownBytecode