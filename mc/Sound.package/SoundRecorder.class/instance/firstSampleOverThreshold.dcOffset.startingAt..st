trimming
firstSampleOverThreshold: threshold dcOffset: dcOffset startingAt: startPlace
	"Beginning at startPlace, this routine will return the first place at which a sample exceeds the given threshold."

	| buf s iStart jStart nThreshold |
	nThreshold := threshold negated.
	iStart := startPlace first.
	jStart := startPlace second.
	iStart to: recordedBuffers size do:
		[:i | buf := recordedBuffers at: i.
		jStart to: buf size do:
			[:j | s := (buf at: j) - dcOffset.
			(s < nThreshold or: [s > threshold]) ifTrue:
				["found a sample over threshold"
				^ Array with: i with: j]].
		jStart := 1].
	^ self endPlace