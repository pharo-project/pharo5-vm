bytecode generators
extendedStoreBytecode
	| variableType variableIndex |
	variableType := byte1 >> 6 bitAnd: 3.
	variableIndex := byte1 bitAnd: 63.
	variableType = 0 ifTrue:
		[^self genStorePop: false ReceiverVariable: variableIndex].
	variableType = 1 ifTrue:
		[^self genStorePop: false TemporaryVariable: variableIndex].
	variableType = 3 ifTrue:
		[^self genStorePop: false LiteralVariable: variableIndex].
	^EncounteredUnknownBytecode