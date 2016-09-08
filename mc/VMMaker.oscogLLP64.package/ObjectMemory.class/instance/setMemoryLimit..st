initialization
setMemoryLimit: newMemoryLimit
	self assert: (newMemoryLimit bitAnd: self wordSize - 1) = 0.
	memoryLimit := newMemoryLimit