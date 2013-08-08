private
computeIncrementAt: mSecs between: p1 and: p2 scale: combinedScale
	"Compute the current and increment values for the given time between the given inflection points."
	"Assume: p1 x <= mSecs <= p2 x"

	| valueRange timeRange |
	valueRange := (p2 y - p1 y) asFloat.
	timeRange := (p2 x - p1 x) asFloat.
	currValue := (p1 y + (((mSecs - p1 x) asFloat / timeRange) * valueRange)) * combinedScale.
	valueIncr := (((p2 y * combinedScale) - currValue) / (p2 x - mSecs)) * 10.0.
	^ currValue
