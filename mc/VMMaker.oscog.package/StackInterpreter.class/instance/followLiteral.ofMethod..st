compiled methods
followLiteral: offset ofMethod: methodPointer
	<api>
	^objectMemory followField: offset + LiteralStart ofObject: methodPointer
