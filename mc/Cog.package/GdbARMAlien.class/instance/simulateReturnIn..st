execution simulation
simulateReturnIn: aMemory
	PostBuildStackDelta ~= 0 ifTrue:
		[self sp: self sp + PostBuildStackDelta].
	self fp: (self popWordIn: aMemory).
	"According to tpr, most C compilers implement return by simply
	 popping into the pc, rather than popping through the link register."
	self pc: (self popWordIn: aMemory)