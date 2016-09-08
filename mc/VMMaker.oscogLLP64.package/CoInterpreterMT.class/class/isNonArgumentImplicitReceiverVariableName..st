translation
isNonArgumentImplicitReceiverVariableName: aString
	^'cogThreadManager' = aString
	   or: [super isNonArgumentImplicitReceiverVariableName: aString]