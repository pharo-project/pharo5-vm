tests
testMultiPassRandomAssortmentsWithNewSegment
	"Test that the compactor can handle multi-pass compaction of some number of
	 random assortments of live, pinned, dead, and free chunks allocated in a new segment."
	<timeout: 60>
	| random |
	random := Random new.
	10 timesRepeat:
		[| theVM |
		 theVM := self initializedVM.
		 theVM objectMemory compactor forceMultiPass.
		 self testRandomAssortmentWithNewSegment: (random next: 5000) readStream
			with: theVM]