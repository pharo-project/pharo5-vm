initialization
initializeStack: theStackPages numSlots: stackSlots pageSize: slotsPerPage
	"Initialize the stack pages.  In the C VM theStackPages will be alloca'ed memory to hold the
	 stack pages on the C stack.  In the simulator they are housed in the memory between the
	 cogMethodZone and the heap."
	<returnTypeC: #void>
	self subclassResponsibility