frame access
bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: flushExtPrims
	"Enumerate all contexts and convert married contexts to widowed contexts so
	 that the snapshot contains only single contexts.  This allows the test for being
	 married to avoid checking for a context's frame pointer being in bounds.  If
	 flushExtPrims is true, flush references to external primitives in methods."
	<asmLabel: false>
	objectMemory allObjectsDo:
		[:obj| | fmt |
		fmt := objectMemory formatOf: obj.
		(fmt = objectMemory indexablePointersFormat
		  and: [objectMemory isContextNonImm: obj]) ifTrue:
			[(self isMarriedOrWidowedContext: obj)
				ifTrue: "The stack pages have already been discarded.  Any remaining married contexts are actually widows."
					[self markContextAsDead: obj]
				ifFalse:
					[self ensureContextHasBytecodePC: obj].
			 "Fill slots beyond top of stack with nil"
			 (self fetchStackPointerOf: obj) + CtxtTempFrameStart
				to: (objectMemory numSlotsOf: obj) - 1
				do: [:i |
					objectMemory
						storePointerUnchecked: i
						ofObject: obj
						withValue: objectMemory nilObject]].
		 "Clean out external functions from compiled methods"
		 (flushExtPrims
		  and: [fmt >= objectMemory firstCompiledMethodFormat]) ifTrue:
			["Its primitiveExternalCall"
			 (self primitiveIndexOf: obj) = PrimitiveExternalCallIndex ifTrue:
				[self flushExternalPrimitiveOf: obj]]]