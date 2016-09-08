gc - scavenging
sufficientSpaceAfterGC: numBytes
	"This is ObjectMemory's funky entry-point into its incremental GC,
	 which is a stop-the-world a young generation reclaimer.  In Spur
	 we run the scavenger.  Answer if space is not low."

	| heapSizePostGC |
	self assert: numBytes = 0.
	self scavengingGCTenuringIf: TenureByAge.
	heapSizePostGC := endOfMemory - nilObj - totalFreeOldSpace.
	(heapSizePostGC - heapSizeAtPreviousGC) asFloat / heapSizeAtPreviousGC >= heapGrowthToSizeGCRatio ifTrue:
		[self fullGC].
	[totalFreeOldSpace < growHeadroom
	 and: [(self growOldSpaceByAtLeast: 0) notNil]] whileTrue:
		[totalFreeOldSpace >= growHeadroom ifTrue:
			[^true]].
	lowSpaceThreshold > totalFreeOldSpace ifTrue: "space is low"
		[lowSpaceThreshold := 0. "avoid signalling low space twice"
		 ^false].
	^true