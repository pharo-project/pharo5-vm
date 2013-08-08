compiled methods
primitiveNewMethod
	| header bytecodeCount class size theMethod literalCount |
	header := self popStack.
	bytecodeCount := self popInteger.
	self success: (self isIntegerObject: header).
	self successful ifFalse:
		[self unPop: 2. ^nil].
	class := self popStack.
	size := (self literalCountOfHeader: header) + 1 * BytesPerWord + bytecodeCount.
	theMethod := self instantiateClass: class indexableSize: size.
	self storePointerUnchecked: HeaderIndex ofObject: theMethod withValue: header.
	literalCount := self literalCountOfHeader: header.
	1 to: literalCount do:
		[:i | self storePointerUnchecked: i ofObject: theMethod withValue: nilObj].
	self push: theMethod