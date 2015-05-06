remembered set
totalRememberedReferentCounts: counts
	<var: 'counts' declareC: 'long counts[MaxRTRefCount + 1]'>
	<inline: true>
	0 to: MaxRTRefCount do:
		[:i| counts at: i put: 0].
	0 to: rememberedSetSize - 1 do:
		[:i| | elephant |
		elephant := rememberedSet at: i.
		0 to: (manager numPointerSlotsOf: elephant) - 1 do:
			[:j| | referent refCount |
			referent := manager fetchPointer: j ofObject: elephant.
			(manager isReallyYoung: referent) ifTrue:
				[refCount := manager rtRefCountOf: referent.
				 counts at: refCount put: (counts at: refCount) + 1]]]