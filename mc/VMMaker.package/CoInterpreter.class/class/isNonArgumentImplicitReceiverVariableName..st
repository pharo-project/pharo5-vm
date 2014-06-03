translation
isNonArgumentImplicitReceiverVariableName: aString
	^(#('self' 'stackPages' 'cogit' 'coInterpreter' 'cogMethodZone' 'interpreter' 'objectMemory') includes: aString)
	  or: [self objectMemoryClass isNonArgumentImplicitReceiverVariableName: aString]