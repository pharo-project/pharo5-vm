memory access
byteSwapped64IfBigEndian: w
	"Accelerate, we now we are not big endian"
	^w bitAnd: 16rFFFFFFFFFFFFFFFF