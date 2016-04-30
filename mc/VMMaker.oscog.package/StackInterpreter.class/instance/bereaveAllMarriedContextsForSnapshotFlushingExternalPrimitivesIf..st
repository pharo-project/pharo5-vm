frame access
bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: flushExtPrims
	"Enumerate all contexts and convert married contexts to widowed contexts so
	 that the snapshot contains only single contexts.  This allows the test for being
	 married to avoid checking for a context's frame pointer being in bounds.  If
	 flushExtPrims is true, flush references to external primitives in methods."
	objectMemory allObjectsDo:
		[:obj| | fmt |
		fmt := objectMemory formatOf: obj.
		(fmt = objectMemory indexablePointersFormat
		  and: [objectMemory isContextNonImm: obj]) ifTrue:
			[self makeContextSnapshotSafe: obj].
		 "Clean out external functions from compiled methods"
		 (flushExtPrims
		  and: [objectMemory isCompiledMethodFormat: fmt]) ifTrue:
			[self flushExternalPrimitiveOf: obj]]