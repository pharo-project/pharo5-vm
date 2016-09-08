arithmetic float primitives
primitiveSmallFloatSquareRoot
	<option: #Spur64BitMemoryManager>

	self pop: 1 thenPushFloat: (objectMemory smallFloatValueOf: self stackTop) sqrt