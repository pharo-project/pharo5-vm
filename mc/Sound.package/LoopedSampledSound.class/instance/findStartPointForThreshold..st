other
findStartPointForThreshold: threshold
	"Answer the index of the last zero crossing sample before the first sample whose absolute value (in either the right or left channel) exceeds the given threshold."

	| i |
	i := self indexOfFirstPointOverThreshold: threshold.
	i >= lastSample ifTrue: [^ self error: 'no sample exceeds the given threshold'].

	"scan backwards to the last zero-crossing"
	(leftSamples at: i) > 0
		ifTrue: [
			[i > 1 and: [(leftSamples at: i) > 0]] whileTrue: [i := i - 1]]
		ifFalse: [
			[i > 1 and: [(leftSamples at: i) < 0]] whileTrue: [i := i - 1]].
	^ i
