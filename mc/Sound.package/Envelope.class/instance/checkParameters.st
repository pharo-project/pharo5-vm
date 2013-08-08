private
checkParameters
	"Verify that the point array, loopStartIndex, and loopStopIndex obey the rules."

	| lastT t |
	points size > 1
		ifFalse: [^ self error: 'the point list must contain at least two points'].
	points first x = 0
		ifFalse: [^ self error: 'the time of the first point must be zero'].
	lastT := points first x.
	2 to: points size do: [:i |
		t := (points at: i) x.
		t >= lastT
			ifFalse: [^ self error: 'the points must be in ascending time order']].

	(loopStartIndex isInteger and:
	 [(loopStartIndex > 0) and: [loopStartIndex <= points size]])
		ifFalse: [^ self error: 'loopStartIndex is not a valid point index'].
	(loopEndIndex isInteger and:
	 [(loopEndIndex > 0) and: [loopEndIndex <= points size]])
		ifFalse: [^ self error: 'loopEndIndex is not a valid point index'].
	 loopStartIndex <= loopEndIndex
		ifFalse: [^ self error: 'loopEndIndex must not precede loopStartIndex'].
