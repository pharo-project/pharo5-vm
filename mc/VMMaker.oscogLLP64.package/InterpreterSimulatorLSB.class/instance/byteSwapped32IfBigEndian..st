memory access
byteSwapped32IfBigEndian: w
	"Accelerate, we now we are not big endian"
	^w bitAnd: 16rFFFFFFFF