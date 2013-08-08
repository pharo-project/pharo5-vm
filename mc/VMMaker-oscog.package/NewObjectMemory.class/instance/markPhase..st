gc -- mark and sweep
markPhase: fullGCFlag
	"Mark phase of the mark and sweep garbage collector. Set 
	 the mark bits of all reachable objects. Free chunks are 
	 untouched by this process."
	"Assume: All non-free objects are initially unmarked. Root 
	 objects were unmarked when they were made roots.
	 (Make sure this stays true!!)."
	| oop statMarkCountPriorToStackPageFreeing |
	<inline: false>
	
	"first of all, reset the ephemerons queue"
	self resetEphemeronsQueue.

	"trace the interpreter's objects, including the active stacks
	 and special objects array"
	self markAndTraceInterpreterOops: fullGCFlag.
	statSpecialMarkCount := statMarkCount.
	"trace the roots"
	1 to: rootTableCount do:
		[:i | 
		oop := rootTable at: i.
		self markAndTrace: oop].
	1 to: extraRootCount do:
		[:i|
		oop := (extraRoots at: i) at: 0.
		(self isIntegerObject: oop) ifFalse:
			[self markAndTrace: oop]].
	statMarkCountPriorToStackPageFreeing := statMarkCount.

	"Now deal with stack pages"	
	fullGCFlag 
		ifFalse: [ self invalidateStackPagesTraceState ]
		ifTrue: [ self markAndTraceRestStackPages ].
	
	"Process ephemerons"
	self processEphemeronsQueue: fullGCFlag.
		
	"Free unused stack pages. Only safe to free stack pages after all have been traced. "
	fullGCFlag ifTrue: [ self freeUnusedStackPages  ].
	
	"Only safe to free any machine code methods after all
	 stack pages have been traced."
	self markAndTraceOrFreeMachineCode: fullGCFlag.
	
	
	statSpecialMarkCount := statSpecialMarkCount + (statMarkCount - statMarkCountPriorToStackPageFreeing)