stack bytecodes
pushLiteralVariable: literalIndex

	self internalPush:
		(objectMemory fetchPointer: ValueIndex ofObject: (self literal: literalIndex)).