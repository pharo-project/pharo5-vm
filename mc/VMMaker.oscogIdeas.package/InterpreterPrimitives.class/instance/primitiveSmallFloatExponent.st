arithmetic float primitives
primitiveSmallFloatExponent
	"Answer the exponent part of this float."
	<option: #Spur64BitMemoryManager>

	self stackTopPut: (objectMemory integerObjectOf: (objectMemory exponentOfSmallFloat: self stackTop) - 1)