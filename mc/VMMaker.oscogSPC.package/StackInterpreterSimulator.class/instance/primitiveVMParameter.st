system control primitives
primitiveVMParameter
	(self stackTop = (objectMemory integerObjectOf: 9)
	 or: [self stackTop = (objectMemory integerObjectOf: 52)]) ifTrue:
		[self halt].
	^super primitiveVMParameter