interpreter access
fetchPointer: fieldIndex ofObject: oop
	"index by word size, and return a pointer as long as the word size"
	self assert: oop >= self startOfMemory.
	self assert: oop + self baseHeaderSize + (fieldIndex << self shiftForWord) < freeStart.
	^super fetchPointer: fieldIndex ofObject: oop