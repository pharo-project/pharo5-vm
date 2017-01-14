translation
isNonArgumentImplicitReceiverVariableName: aString
	^(#('self' 'stackPages' 'interpreter' 'coInterpreter' 'objectMemory') includes: aString)
	  or: [self objectMemoryClass isNonArgumentImplicitReceiverVariableName: aString]