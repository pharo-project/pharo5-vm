generation scavenging
sufficientSpaceAfterGC: numBytes
	"This is ObjectMemory's funky entry-point into its incremental GC,
	 which is a stop-the-world a young generation reclaimer.  In Spur
	 we run the scavenger.  Answer if space is not low."

	self assert: numBytes = 0.
	self scavengingGC.
	lowSpaceThreshold > totalFreeOldSpace ifTrue: "space is low"
		[lowSpaceThreshold := 0. "avoid signalling low space twice"
		 ^false].
	^true