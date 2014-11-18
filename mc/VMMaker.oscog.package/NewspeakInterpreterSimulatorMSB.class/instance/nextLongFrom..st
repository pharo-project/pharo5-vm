initialization
nextLongFrom: aStream 
	"Read a 32- or 64-bit quantity from the given (binary) stream."

	^ aStream nextNumber: self wordSize