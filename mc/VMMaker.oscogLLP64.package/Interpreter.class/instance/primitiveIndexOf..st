compiled methods
primitiveIndexOf: methodPointer
	"Note: We now have 10 bits of primitive index, but they are in two places
	for temporary backward compatibility.  The time to unpack is negligible,
	since the reconstituted full index is stored in the method cache."
	| primBits |
	primBits := ((self methodHeaderOf: methodPointer) >> 1) bitAnd: 16r100001FF.
	
	^(primBits bitAnd: 16r1FF) + (primBits >> 19)