system control primitives
primitiveQuit

	self ioExitWithErrorCode: (argumentCount = 1 ifTrue: [objectMemory integerValueOf: self stackTop] ifFalse: [0])