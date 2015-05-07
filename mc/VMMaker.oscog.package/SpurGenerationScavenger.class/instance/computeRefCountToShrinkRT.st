remembered set
computeRefCountToShrinkRT
	"Some time in every scavenger's life there may come a time when someone writes code that stresses
	 the remembered table.  One might conclude that if the remembered table is full, then the right thing
	 to do is simply to tenure everything, emptying the remembered table.  Bt in some circumstances this
	 can be counter-productive, and result in the same situation arising soon after tenuring everything.
	 Instead, we can try and selectively prune the remembered table, tenuring only those objects that
	 are referenced by many objects in the remembered table.  That's what this algorithm does.  It
	 reference counts young objects referenced from the remembered set, and then sets a threshold
	 used to tenure objects oft referenced from the remembered set, thereby allowing  the remembered
	 set to shrink, while not tenuring everything.

	 Once in a network monitoring application in a galaxy not dissimilar from the one this code inhabits,
	 a tree of nodes referring to large integers was in precisely this situation.  The nodes were old, and
	 the integers were in new space.  Some of the nodes referred to shared numbers, some their own
	 unique numbers.  The numbers were updated frequently. Were new space simply tenured when the
	 remembered table was full, the remembered table would soon fill up as new numbers were computed.
	 Only by selectively pruning the remembered table of nodes that shared data, was a balance achieved
	 whereby the remembered table population was kept small, and tenuring rates were low."
	<inline: #never>
	| population |
	<var: 'population' declareC: 'long population[MaxRTRefCount + 1]'>
	self cCode: [self me: population ms: 0 et: (self sizeof: #long) * (MaxRTRefCount + 1)]
		inSmalltalk: [population := CArrayAccessor on: (Array new: MaxRTRefCount + 1 withAll: 0)].
	self assert: self allNewSpaceObjectsHaveZeroRTRefCount.
	self referenceCountRememberedReferents: population.
	self setRefCountToShrinkRT: population

	"For debugging:
	(manager allNewSpaceObjectsDo: [:o| manager rtRefCountOf: o put: 0])"