applying
reset
	"Reset the state for this envelope."

	lastValue := -100000.0.  "impossible value"
	nextRecomputeTime := 0.
	self updateTargetAt: 0.
