oop/chunk conversion
chunkFromOop: oop
	"Compute the chunk of this oop by subtracting its extra header bytes."

	^ oop - (self extraHeaderBytes: oop)