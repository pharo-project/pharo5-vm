compiled methods
followLiteral: offset ofMethod: methodPointer
	^objectMemory followField: offset + LiteralStart ofObject: methodPointer
