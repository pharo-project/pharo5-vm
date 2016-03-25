util
digitSizeOfLargeInt: bytesOop 
	"Precondition: bytesOop is not anInteger and a bytes object."
	^ interpreterProxy slotSizeOf: bytesOop