arithmetic float primitives
primitiveSmallFloatLogN
	"Natural log."
	<option: #Spur64BitMemoryManager>
	| rcvr |
	<var: #rcvr type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self stackTopPut: (objectMemory floatObjectOf: (self cCode: [rcvr log] inSmalltalk: [rcvr ln]))