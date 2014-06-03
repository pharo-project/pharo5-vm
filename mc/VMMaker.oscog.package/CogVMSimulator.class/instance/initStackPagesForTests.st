test support
initStackPagesForTests
	numStackPages := 8.
	stackPages := self stackPagesClass new.
	objectMemory allocateMemoryOfSize: 1024 * 1024.
	cogCodeSize := 0.
	heapBase := self methodCacheSize
				+ self primTraceLogSize
				+ self rumpCStackSize
				+ self computeStackZoneSize.
	self initStackPages