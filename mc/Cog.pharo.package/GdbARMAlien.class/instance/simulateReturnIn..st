execution simulation
simulateReturnIn: aMemory
"simulate a return; this may get a bit more complicated since we are trying to compensate for the IA32 automagically pushing the return address whereas the ARM doesn't."
self halt.
	PostBuildStackDelta ~= 0 ifTrue:
		[self sp: self sp + PostBuildStackDelta].
	self fp: (self popWordIn: aMemory).
	self lr: (self popWordIn: aMemory).
	self pc: self lr