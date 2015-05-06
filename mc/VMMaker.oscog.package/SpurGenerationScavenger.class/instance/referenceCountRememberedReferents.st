remembered set
referenceCountRememberedReferents
	"Reference count each referent of the remembered table using the rtRefCount
	 field comprised of isGrey,isPinned,isRemembered.  i.e. produce a reference
	 count from 1 to 7 in all objects accessible from the RT."
	<inline: true>
	0 to: rememberedSetSize - 1 do:
		[:i| | elephant |
		elephant := rememberedSet at: i.
		0 to: (manager numPointerSlotsOf: elephant) - 1 do:
			[:j| | referent refCount |
			referent := manager fetchPointer: j ofObject: elephant.
			(manager isReallyYoung: referent) ifTrue:
				[refCount := manager rtRefCountOf: referent.
				 (refCount := refCount + 1) <= MaxRTRefCount ifTrue:
					[manager rtRefCountOf: referent put: refCount]]]]