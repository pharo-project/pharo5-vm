interpreter access
fetchPointer: fieldIndex ofObject: oop
	"index by word size, and return a pointer as long as the word size"
	self assert: (objectMemory cheapIsInMemory: oop).
	^objectMemory fetchPointer: fieldIndex ofObject: oop