translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Remove the methods and instance variables we don't use."

	self ~~ NewObjectMemory ifTrue: "No Need to repeat in NewCoObjectMemory"
		[^self].

	aCodeGen
		removeMethodForSelector: #markPhase; "we implement markPhase:"
		removeMethodForSelector: #printWronglySizedContexts. "we implement printWronglySizedContexts:"
	"This class uses freeStart in place of freeBlock.  It does
	 not maintain an allocationCount nor stats there-of.
	 Having an interpreter that uses a stack zone, it doesn't
	 need an optimized context allocator."
	aCodeGen
		removeVariable: 'freeBlock';
		removeVariable: 'allocationCount';
		removeVariable: 'allocationsBetweenGCs';
		removeVariable: 'statAllocationCount';
		removeVariable: 'freeContexts';
		removeVariable: 'freeLargeContexts';
		removeVariable: 'statGCEndTime' "replaced by statGCEndUsecs"