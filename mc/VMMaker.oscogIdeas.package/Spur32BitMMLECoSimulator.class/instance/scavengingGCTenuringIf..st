gc - global
scavengingGCTenuringIf: tenuringCriterion
	"If we're /not/ a clone, clone the VM and push it over the cliff.
	 If it survives, destroy the clone and continue.  We should be OK until next time."
	(self leakCheckNewSpaceGC
	 and: [parent isNil]) ifTrue:
		[coInterpreter cr; print: 'scavenge '; print: statScavenges; tab; flush.
		 coInterpreter cloneSimulation objectMemory scavengingGCTenuringIf: tenuringCriterion.
		 Smalltalk garbageCollect].
	^super scavengingGCTenuringIf: tenuringCriterion