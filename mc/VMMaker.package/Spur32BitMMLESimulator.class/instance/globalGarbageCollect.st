gc - global
globalGarbageCollect
	"If we're /not/ a clone, clone the VM and push it over the cliff.
	 If it survives, destroy the clone and continue.  We should be OK until next time."
	parent ifNil:
		[[coInterpreter cloneSimulation objectMemory globalGarbageCollect]
			on: Halt
			do: [:ex|
				(ex messageText beginsWith: 'GC number')
					ifTrue:
						[Transcript cr; cr; show: ex messageText; cr; cr.
						 ex resume]
					ifFalse: [ex pass]].
		 Smalltalk garbageCollect].
	^super globalGarbageCollect