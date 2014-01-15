compiled methods
literal: offset ofMethod: methodPointer

	^ objectMemory fetchPointer: offset + LiteralStart ofObject: methodPointer
