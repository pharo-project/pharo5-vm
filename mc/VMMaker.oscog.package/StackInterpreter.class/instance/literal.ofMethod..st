compiled methods
literal: offset ofMethod: methodPointer
	<api>
	^objectMemory fetchPointer: offset + LiteralStart ofObject: methodPointer
