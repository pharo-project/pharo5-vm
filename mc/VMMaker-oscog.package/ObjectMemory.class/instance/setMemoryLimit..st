initialization
setMemoryLimit: newMemoryLimit
	self assert: (newMemoryLimit bitAnd: BytesPerWord - 1) = 0.
	memoryLimit := newMemoryLimit