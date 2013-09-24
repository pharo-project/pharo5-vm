simulation
startOfMemory: value
	startOfMemory := value.
	(freeStart isNil or: [freeStart < value]) ifTrue:
		[freeStart := value]