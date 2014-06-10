execution simulation
simulateLeafReturnIn: aMemory
"simulate a leaf return; this may get a bit more complicated since we are trying to compensate for the IA32 automagically pushing the return address whereas the ARM doesn't."
self halt.
	self pc: self lr