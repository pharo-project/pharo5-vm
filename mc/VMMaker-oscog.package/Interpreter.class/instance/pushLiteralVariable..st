stack bytecodes
pushLiteralVariable: literalIndex

	self internalPush:
		(self fetchPointer: ValueIndex ofObject: (self literal: literalIndex)).