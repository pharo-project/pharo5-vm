tests
testRandomAssortmentsWithNewSegment
	"Test that the compactor can handle some number of random assortments of live, pinned, dead, and free chunks
	 allocated in a new segment."
	<timeout: 60>
	| random |
	random := Random new.
	10 timesRepeat:
		[self testRandomAssortmentWithNewSegment: (random next: 6000) readStream
			with: self initializedVM]