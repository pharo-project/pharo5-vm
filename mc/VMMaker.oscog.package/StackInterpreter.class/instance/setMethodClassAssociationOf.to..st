compiled methods
setMethodClassAssociationOf: methodPointer to: anObject
	objectMemory
		storePointer: (self literalCountOf: methodPointer) + LiteralStart - 1
		ofObject: methodPointer
		withValue: anObject