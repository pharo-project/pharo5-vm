instruction decoding
callInlinePrimitive: primitiveIndex
	"The convention for inline primitives is that the argument count is primitiveIndex // 1000 - 1,
	 so receiverless 0-arg prims are from 0 to 999 (does this even make sense?), 0-arg prims
	 are from 1 to 1999, 2-arg prims from 1000 to 1999, and so on."
	self drop: (primitiveIndex // 1000 - 1 max: 0)