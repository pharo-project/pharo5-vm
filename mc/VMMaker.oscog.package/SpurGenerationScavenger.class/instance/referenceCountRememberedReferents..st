remembered set
referenceCountRememberedReferents: population
	"Both reference count young objects reachable from the RT,
	 and count the populations of each ref count, in a single pass."
	<var: 'population' declareC: 'long population[MaxRTRefCount + 1]'>
	<inline: true>
	0 to: rememberedSetSize - 1 do:
		[:i| | elephant |
		elephant := rememberedSet at: i.
		(manager isForwarded: elephant) ifTrue:
			[elephant := manager followForwarded: elephant.
			 (manager isImmediate: elephant) ifTrue: "take care if elephant forwarded to an immediate"
				[elephant := manager nilObject]].
		0 to: (manager numPointerSlotsOf: elephant) - 1 do:
			[:j| | referent refCount |
			referent := manager fetchPointer: j ofObject: elephant.
			(manager isReallyYoung: referent) ifTrue:
				[refCount := manager rtRefCountOf: referent.
				 refCount < MaxRTRefCount ifTrue:
					[refCount > 0 ifTrue:
						[population at: refCount put: (population at: refCount) - 1].
					 refCount := refCount + 1.
					 manager rtRefCountOf: referent put: refCount.
					 population at: refCount put: (population at: refCount) + 1]]]].