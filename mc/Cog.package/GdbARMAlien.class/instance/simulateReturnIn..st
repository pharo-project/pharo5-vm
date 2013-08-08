execution simulation
simulateReturnIn: aMemory
	PostBuildStackDelta ~= 0 ifTrue:
		[self sp: self sp + PostBuildStackDelta].
	self r11: (self popWordIn: aMemory).
	self pc: (self popWordIn: aMemory)