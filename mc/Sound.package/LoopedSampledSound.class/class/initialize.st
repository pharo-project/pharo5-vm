initialization
initialize
	"LoopedSampledSound initialize"

	LoopIndexScaleFactor := 512.
	FloatLoopIndexScaleFactor := LoopIndexScaleFactor asFloat.
	LoopIndexFractionMask := LoopIndexScaleFactor - 1.
