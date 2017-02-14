arithmetic float primitives
primitiveSmallFloatSquareRoot
	<option: #Spur64BitMemoryManager>
	| rcvr |
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	rcvr >= 0.0
		ifTrue: [self stackTopPut: (objectMemory floatObjectOf: rcvr sqrt)]
		ifFalse: [self primitiveFail]