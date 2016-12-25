simulation only
sqDeallocateMemorySegmentAt: startAddress OfSize: ammount
	"This is a nop in the simulator, except for SpurPlanningCompactor which may
	 release at the end of memory, allowing the simulator to shrink memory."
	<doNotGenerate>
	startAddress >= endOfMemory ifTrue:
		[self halt]