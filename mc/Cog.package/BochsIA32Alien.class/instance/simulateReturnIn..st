execution
simulateReturnIn: aMemory
	PostBuildStackDelta ~= 0 ifTrue:
		[self esp: self esp + PostBuildStackDelta].
	self ebp: (self popWordIn: aMemory).
	self eip: (self popWordIn: aMemory)