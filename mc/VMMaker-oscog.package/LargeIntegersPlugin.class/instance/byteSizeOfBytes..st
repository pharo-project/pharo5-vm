util
byteSizeOfBytes: bytesOop 
	"Precondition: bytesOop is not anInteger and a bytes object."
	"Function #byteSizeOf: is used by the interpreter, be careful with name
	clashes..."
	^ interpreterProxy slotSizeOf: bytesOop