system control primitives
primitiveVMParameter
	(argumentCount = 2
	 and: [(self stackValue: 1) = (objectMemory integerObjectOf: 34)]) ifTrue:
		[self halt].
	^super primitiveVMParameter