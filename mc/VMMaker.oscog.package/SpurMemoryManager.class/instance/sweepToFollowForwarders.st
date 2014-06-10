compaction
sweepToFollowForwarders
	"sweep, following forwarders in all live objects, and answering the first forwarder or free object."
	| lowestFree |
	lowestFree := 0.
	self allOldSpaceEntitiesDo:
		[:o|
		((self isFreeObject: o) or: [self isForwarded: o])
			ifTrue:
				[lowestFree = 0 ifTrue:
					[lowestFree := o]]
			ifFalse:
				[0 to: (self numPointerSlotsOf: o) - 1 do:
					[:i| | f |
					f := self fetchPointer: i ofObject: o.
					(self isOopForwarded: f) ifTrue:
						[f := self followForwarded: f.
						 self storePointer: i ofObject: o withValue: f]]]].
	^lowestFree
