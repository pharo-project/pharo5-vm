translation
isNonArgumentImplicitReceiverVariableName: aString
	aString = 'interpreterProxy' ifTrue: [self halt].
	^'self' = aString