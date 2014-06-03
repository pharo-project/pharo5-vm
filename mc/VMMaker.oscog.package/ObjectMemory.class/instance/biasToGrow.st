garbage collection
biasToGrow
	| growSize |
	growSize :=  growHeadroom*3/2 - (self sizeOfFree: freeBlock).
	self growObjectMemory: growSize