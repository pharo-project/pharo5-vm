bootstrap image
convertOldMethodHeader: methodHeader
	^((oldInterpreter argumentCountOfMethodHeader: methodHeader) << 24)
	 + ((oldInterpreter temporaryCountOfMethodHeader: methodHeader) << 18)
	 + ((oldInterpreter methodHeaderIndicatesLargeFrame: methodHeader) ifTrue: [1 << 17] ifFalse: [0])
	 + ((oldInterpreter methodHeaderHasPrimitive: methodHeader) ifTrue: [1 << 16] ifFalse: [0])
	 + (oldHeap literalCountOfMethodHeader: methodHeader)