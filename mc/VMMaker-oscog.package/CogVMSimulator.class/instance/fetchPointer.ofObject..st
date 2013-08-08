interpreter access
fetchPointer: fieldIndex ofObject: oop
	"index by word size, and return a pointer as long as the word size"
	self assert: oop >= objectMemory startOfMemory.
	^objectMemory fetchPointer: fieldIndex ofObject: oop