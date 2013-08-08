initialization
setEndOfMemory: newEndOfMemory
	super setEndOfMemory: newEndOfMemory.
	freeStart isNil ifTrue:
		[freeStart := newEndOfMemory]