gc -- mark and sweep
markPhase
	"Mark phase of the mark and sweep garbage collector. Set 
	the mark bits of all reachable objects. Free chunks are 
	untouched by this process."
	"Assume: All non-free objects are initially unmarked. Root 
	objects were unmarked when they were made roots. (Make 
	sure this stays true!!)."
	| oop |
	<inline: false>
	"clear the recycled context lists"
	freeContexts := NilContext.
	freeLargeContexts := NilContext.
	"trace the interpreter's objects, including the active stack 
	and special objects array"
	self markAndTraceInterpreterOops.
	statSpecialMarkCount := statMarkCount.
	"trace the roots"
	1 to: rootTableCount do: [:i | 
		oop := rootTable at: i.
		self markAndTrace: oop].
	1 to: extraRootCount do:[:i|
		oop := (extraRoots at: i) at: 0.
		((self isIntegerObject: oop) or: [self isFreeObject: oop]) ifFalse:
			[self markAndTrace: oop]].
