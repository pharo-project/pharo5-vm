translation
prepareToBeAddedToCodeGenerator: aCodeGen
	"Remove the superclass methods we override
	 and the instance variables we don't use."
	self selectors do:
		[:sel|
		 (superclass whichClassIncludesSelector: sel) ifNotNil:
			[aCodeGen removeMethodForSelector: sel]].
	self ~~ NewObjectMemory ifTrue:
		[^self].
	aCodeGen removeMethodForSelector: #markPhase. "we implement markPhase:"
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