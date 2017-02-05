tests
testMultiPassRandomAssortments
	"Test that the compactor can handle multi-pass compaction of some
	 number of random assortments of live, pinned, dead, and free chunks."
	<timeout: 60>
	| random |
	random := Random new.
	10 timesRepeat:
		[| theVM |
		 theVM := self initializedVM.
		 theVM objectMemory compactor forceMultiPass.
		 self testRandomAssortment: (random next: 3000) readStream
			with: theVM]