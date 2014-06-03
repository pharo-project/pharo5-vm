bytecode generators
callPrimitiveBytecode
	"249		11111001	i i i i i i i i	jjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjjj * 256)"
	self assert: (primitiveIndex = (byte1 + (byte2 << 8))
				or: [primitiveIndex = 0 "disabled primitives, e.g. stream prims"
					and: [(coInterpreter primitiveIndexOf: methodObj) = (byte1 + (byte2 << 8))]]).
	^0