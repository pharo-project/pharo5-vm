gc -- mark and sweep
incrementalGC
	"If we're /not/ a clone, clone the VM and push it over the cliff.
	 If it survives, destroy the clone and continue.  We should be OK until next time."
	(self leakCheckNewSpaceGC
	 and: [parent isNil]) ifTrue:
		[coInterpreter cr; print: 'Incremental GC number '; print: statIncrGCs; tab; flush.
		 coInterpreter cloneSimulation objectMemory incrementalGC.
		 Smalltalk garbageCollect].
	^super incrementalGC