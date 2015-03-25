execution simulation
simulateReturnIn: aMemory
	PostBuildStackDelta ~= 0 ifTrue:
		[self sp: self sp + PostBuildStackDelta].
	self fp: (self popWordIn: aMemory).
	self lr: (self popWordIn: aMemory).
	self pc: self lr