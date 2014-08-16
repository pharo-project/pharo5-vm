munging
convertOldMethodHeader: methodHeader
	^heap integerObjectOf:
		   ((interpreter argumentCountOfMethodHeader: methodHeader) << 24)
		+ ((interpreter temporaryCountOfMethodHeader: methodHeader) << 18)
		+ ((interpreter methodHeaderIndicatesLargeFrame: methodHeader) ifTrue: [1 << 17] ifFalse: [0])
		+ ((heap primitiveIndexOfMethodHeader: methodHeader) > 0 ifTrue: [1 << 16] ifFalse: [0])
		+ (heap literalCountOfMethodHeader: methodHeader)