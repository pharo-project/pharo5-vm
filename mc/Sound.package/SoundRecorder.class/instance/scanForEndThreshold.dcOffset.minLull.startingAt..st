trimming
scanForEndThreshold: threshold dcOffset: dcOffset minLull: lull startingAt: startPlace
	"Beginning at startPlace, this routine will find the last sound that exceeds threshold, such that if you look lull samples later you will not find another sound over threshold within the following block of lull samples.
	Return the place that is lull samples beyond to that last sound.
	If no end of sound is found, return endPlace."

	| buf s iStart jStart nThreshold n |
	nThreshold := threshold negated.
	iStart := startPlace first.
	jStart := startPlace second.
	n := 0.
	iStart to: recordedBuffers size do:
		[:i | buf := recordedBuffers at: i.
		jStart to: buf size do:
			[:j | s := (buf at: j) - dcOffset.
			(s < nThreshold or: [s > threshold])
				ifTrue: ["found a sample over threshold"
						n := 0]
				ifFalse: ["still not over threshold"
						n := n + 1.
						n >= lull ifTrue: [^ Array with: i with: j]]].
		jStart := 1].
	^ self endPlace