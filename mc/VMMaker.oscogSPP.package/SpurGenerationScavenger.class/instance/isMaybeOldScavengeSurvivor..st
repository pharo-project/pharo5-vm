weakness and ephemerality
isMaybeOldScavengeSurvivor: oop
	"Answer whether the oop has survived a scavenge.  This version is
	 for processing weak survivors and must cope with the scavenge in
	 freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact."
	| target |
	(manager isImmediate: oop) ifTrue:
		[^true].
	(manager isForwarded: oop)
		ifTrue:
			[target := manager followForwarded: oop.
			 (manager isImmediate: oop) ifTrue:
				[^true]]
		ifFalse: [target := oop].
	^(manager isOldObject: target)
		ifTrue:
			[tenureCriterion ~= MarkOnTenure
			 or: [manager isMarked: target]]
		ifFalse:
			[manager isInFutureSpace: target]