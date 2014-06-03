primitive support
primitiveAccessorDepthForExternalPrimitiveMethod: methodObj
	^objectMemory integerValueOf:
		(objectMemory
			fetchPointer: 2
			ofObject: (self literal: 0 ofMethod: methodObj))