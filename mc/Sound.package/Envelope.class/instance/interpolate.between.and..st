private
interpolate: mSecs between: p1 and: p2
	"Return the scaled, interpolated value for the given time between the given time points."
	"Assume: p1 x <= mSecs <= p2 x"

	| valueRange timeRange |
	valueRange := (p2 y - p1 y) asFloat.
	valueRange = 0.0 ifTrue: [^ p1 y * scale].
	timeRange := (p2 x - p1 x) asFloat.
	^ (p1 y + (((mSecs - p1 x) asFloat / timeRange) * valueRange)) * scale.
