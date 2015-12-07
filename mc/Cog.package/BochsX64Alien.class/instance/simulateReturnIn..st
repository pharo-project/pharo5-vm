execution
simulateReturnIn: aMemory
	PostBuildStackDelta ~= 0 ifTrue:
		[self rsp: self rsp + PostBuildStackDelta].
	self rbp: (self popWordIn: aMemory).
	self rip: (self popWordIn: aMemory)