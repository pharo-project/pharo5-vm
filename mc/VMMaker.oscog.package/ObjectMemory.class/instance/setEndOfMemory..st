initialization
setEndOfMemory: newEndOfMemory
	self assert: (newEndOfMemory bitAnd: self wordSize - 1) = 0.
	endOfMemory := newEndOfMemory