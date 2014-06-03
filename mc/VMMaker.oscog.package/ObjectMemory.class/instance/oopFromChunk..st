oop/chunk conversion
oopFromChunk: chunk
	"Compute the oop of this chunk by adding its extra header bytes."

	^ chunk + (self extraHeaderBytes: chunk)