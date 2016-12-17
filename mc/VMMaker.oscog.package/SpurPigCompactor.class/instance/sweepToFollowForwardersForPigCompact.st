compaction
sweepToFollowForwardersForPigCompact
	"Sweep, following forwarders in all live objects.
	 Answer the lowest forwarder in oldSpace."
	| lowestForwarder |
	<var: #lowestForwarder type: #usqInt>
	self assert: (manager freeStart = scavenger eden start
				  and: [scavenger futureSurvivorStart = scavenger futureSpace start]).
	manager allPastSpaceObjectsDo:
		[:o|
		(manager isForwarded: o) ifFalse:
			[0 to: (manager numPointerSlotsOf: o) - 1 do:
				[:i| | f |
				f := manager fetchPointer: i ofObject: o.
				(manager isOopForwarded: f) ifTrue:
					[f := manager followForwarded: f.
					 manager storePointerUnchecked: i ofObject: o withValue: f]]]].
	lowestForwarder := 0.
	manager allOldSpaceObjectsDo:
		[:o|
		(manager isForwarded: o)
			ifTrue:
				[lowestForwarder = 0 ifTrue:
					[lowestForwarder := o]]
			ifFalse:
				[0 to: (manager numPointerSlotsOf: o) - 1 do:
					[:i| | f |
					f := manager fetchPointer: i ofObject: o.
					(manager isOopForwarded: f) ifTrue:
						[f := manager followForwarded: f.
						 manager storePointer: i ofObject: o withValue: f]]]].
	^lowestForwarder