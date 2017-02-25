object enumeration
firstObject
	"Return the first object or free chunk in the heap."

	^ self oopFromChunk: self startOfMemory