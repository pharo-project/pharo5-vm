compiled methods
literal: offset ofMethod: methodPointer

	^ self fetchPointer: offset + LiteralStart ofObject: methodPointer
