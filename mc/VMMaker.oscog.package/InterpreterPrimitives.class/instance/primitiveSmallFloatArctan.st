arithmetic float primitives
primitiveSmallFloatArctan
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self stackTopPut: (objectMemory floatObjectOf: (self cCode: [rcvr atan]
														inSmalltalk: [rcvr arcTan]))