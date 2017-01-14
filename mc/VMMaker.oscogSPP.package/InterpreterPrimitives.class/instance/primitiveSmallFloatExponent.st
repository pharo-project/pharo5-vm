arithmetic float primitives
primitiveSmallFloatExponent
	"Answer the exponent part of this float."
	<option: #Spur64BitMemoryManager>

	self pop: 1 thenPushInteger: (objectMemory exponentOfSmallFloat: self stackTop) - 1