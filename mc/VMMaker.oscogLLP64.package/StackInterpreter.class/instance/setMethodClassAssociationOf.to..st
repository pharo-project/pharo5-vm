compiled methods
setMethodClassAssociationOf: methodPointer to: anObject
	objectMemory
		storePointer: (objectMemory literalCountOf: methodPointer) + LiteralStart - 1
		ofObject: methodPointer
		withValue: anObject