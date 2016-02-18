arithmetic float primitives
primitiveSmallFloatHash
	"Answer the ieee 754 double precision floating point bits of the SmallFloat receiver."
	<option: #Spur64BitMemoryManager>

	self pop: 1 thenPush: (objectMemory positive64BitIntegerFor: (objectMemory smallFloatBitsOf: self stackTop))