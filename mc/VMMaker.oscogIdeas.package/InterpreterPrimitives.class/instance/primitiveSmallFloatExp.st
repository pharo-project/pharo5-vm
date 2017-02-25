arithmetic float primitives
primitiveSmallFloatExp
	"Computes E raised to the receiver power.
	 Since SmallFloats cannot represent NaNs there's no need to special case."
	<option: #Spur64BitMemoryManager>

	self stackTopPut: (objectMemory floatObjectOf: (objectMemory smallFloatValueOf: self stackTop) exp)