stack bytecodes
pushReceiverVariable: fieldIndex

	self internalPush: (objectMemory fetchPointer: fieldIndex ofObject: self receiver).