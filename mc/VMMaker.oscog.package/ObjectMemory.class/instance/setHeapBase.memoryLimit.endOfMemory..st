initialization
setHeapBase: baseOfHeap memoryLimit: memLimit endOfMemory: memEnd
	"Set the dimensions of the heap, answering the start of oldSpace."
	self setMemoryLimit: memLimit.
	self setEndOfMemory: memEnd.
	^baseOfHeap