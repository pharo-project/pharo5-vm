examples
scaleTest
	"AbstractSound scaleTest play"

	^ MixedSound new
		add: FMSound majorScale pan: 0;
		add: (PluckedSound lowMajorScale delayedBy: 0.5) pan: 1.0.
