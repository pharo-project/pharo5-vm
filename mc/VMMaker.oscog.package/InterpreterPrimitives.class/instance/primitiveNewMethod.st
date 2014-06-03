compiled methods
primitiveNewMethod
	| header bytecodeCount class size theMethod literalCount |
	header := self stackTop.
	bytecodeCount := self stackIntegerValue: 1.
	self success: (objectMemory isIntegerObject: header).
	self successful ifFalse: [^nil].
	class := self stackValue: 2.
	size := (self literalCountOfHeader: header) + 1 * BytesPerWord + bytecodeCount.
	theMethod := objectMemory instantiateClass: class indexableSize: size.
	objectMemory storePointerUnchecked: HeaderIndex ofObject: theMethod withValue: header.
	literalCount := self literalCountOfHeader: header.
	1 to: literalCount do:
		[:i | objectMemory storePointer: i ofObject: theMethod withValue: objectMemory nilObject].
	self pop: 3 thenPush: theMethod