internal interpreter access
getCogMethodCount
	^objectMemory integerObjectOf: (cogMethodZone numMethodsOfType: CMMethod)