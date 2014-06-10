memory access
byteSwapped: w
	"Return the given integer with its bytes in the reverse order."

	^ (super byteSwapped: ((w bitShift: -32) bitAnd: 16rFFFFFFFF)) +
	  ((super byteSwapped: (w bitAnd: 16rFFFFFFFF)) bitShift: 32)