compiled methods
primitiveNewMethod
	| header bytecodeCount class size theMethod literalCount |
	header := self stackTop.
	bytecodeCount := self stackValue: 1.
	((objectMemory isIntegerObject: header)
	 and: [(objectMemory isIntegerObject: bytecodeCount)
	 and: [(bytecodeCount := objectMemory integerValueOf: bytecodeCount) >= 0]]) ifFalse:
		[self primitiveFailFor: PrimErrBadArgument.
		 ^self].
	class := self stackValue: 2.
	literalCount := objectMemory literalCountOfMethodHeader: header.
	size := literalCount + LiteralStart * objectMemory bytesPerOop + bytecodeCount.
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[theMethod := objectMemory instantiateCompiledMethodClass: class indexableSize: size.
			 theMethod ifNil:
				[self primitiveFailFor: ((objectMemory isCompiledMethodFormat: (objectMemory instSpecOfClass: class))
										ifTrue: [PrimErrNoMemory]
										ifFalse: [PrimErrBadReceiver]).
				 ^self]]
		ifFalse:
			[theMethod := objectMemory instantiateClass: class indexableSize: size].
	objectMemory storePointerUnchecked: HeaderIndex ofObject: theMethod withValue: header.
	1 to: literalCount do:
		[:i | objectMemory storePointer: i ofObject: theMethod withValue: objectMemory nilObject].
	self pop: 3 thenPush: theMethod