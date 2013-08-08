initialization
setEndOfMemory: newEndOfMemory
	self assert: (newEndOfMemory bitAnd: BytesPerWord - 1) = 0.
	endOfMemory := newEndOfMemory