arithmetic float primitives
primitiveSmallFloatSine
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self stackTopPut: (objectMemory floatObjectOf: rcvr sin)