util
byteSizeOfLargeInt: bytesOop 
	"Answer the number of bytes required to represent a LargeInteger.
	Precondition: bytesOop is not a small integer."
	^ interpreterProxy slotSizeOf: bytesOop