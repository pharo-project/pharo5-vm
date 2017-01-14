tests
testRandomAssortments
	"Test that the compactor can handle some number of random assortments of live, pinned, dead, and free chunks."
	<timeout: 60>
	| random |
	random := Random new.
	10 timesRepeat: [self testRandomAssortment: (random next: 3000) readStream]