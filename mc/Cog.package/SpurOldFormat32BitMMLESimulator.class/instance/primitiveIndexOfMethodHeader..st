method access
primitiveIndexOfMethodHeader: methodHeader
	| primBits |
	primBits := (self integerValueOf: methodHeader) bitAnd: 16r100001FF.
	^(primBits bitAnd: 16r1FF) + (primBits >> 19)