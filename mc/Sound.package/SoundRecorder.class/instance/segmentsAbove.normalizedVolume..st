trimming
segmentsAbove: threshold normalizedVolume: percentOfMaxVolume
	"Break the current recording up into a sequence of sound segments separated by silences."

	| dcOffset firstPlace endPlace resultBuf nFactor lastPlace segments gapSize minDur minLull soundSize restSize max min sum totalSamples |
	stereo ifTrue: [self error: 'stereo trimming is not yet supported'].
	paused ifFalse: [self error: 'must stop recording before trimming'].
	(recordedSound == nil or: [recordedSound sounds isEmpty]) ifTrue:[^ self].
	"Reconstruct buffers so old trimming code will work"
	recordedBuffers := recordedSound sounds collect: [:snd | snd samples].
	soundSize := restSize := 0.

	max := min := sum := totalSamples := 0.
	recordedBuffers do: [:buf | | bufSize s |
		bufSize := buf size.
		totalSamples := totalSamples + buf size.
		1 to: bufSize do: [:i |
			s := buf at: i.
			s > max ifTrue: [max := s].
			s < min ifTrue: [min := s].
			sum := sum + s]].
	dcOffset := sum // totalSamples.

	minDur := (samplingRate/20.0) asInteger.  " 1/20 second "
	minLull := (samplingRate/4.0) asInteger.  " 1/2 second "
	segments := SequentialSound new.
	endPlace := self endPlace.
	lastPlace := #(1 1).
	[firstPlace := self scanForStartThreshold: threshold
						dcOffset: dcOffset
						minDur: minDur
						startingAt: lastPlace.
	firstPlace = endPlace]
		whileFalse:
		[firstPlace = lastPlace ifFalse:
			["Add a silence equal to the gap size"
			"Wasteful but simple way to get gap size..."
			gapSize := (self copyFrom: lastPlace to: firstPlace
						normalize: 1000 dcOffset: dcOffset) size - 2.
			"... -2 makes up for overlap of one sample on either end"
			segments add: (RestSound dur: gapSize asFloat / samplingRate).
			restSize := restSize + gapSize.
"Transcript cr; print: firstPlace; space; print: lastPlace; space; print: gapSize; space; show: 'gap'."
			].
		lastPlace := self scanForEndThreshold: threshold
						dcOffset: dcOffset
						minLull: minLull + minDur
						startingAt: firstPlace.
		"Allow room for lead time of next sound"
		lastPlace := self place: lastPlace plus: minDur negated.
		nFactor := self normalizeFactorFor: percentOfMaxVolume
						min: min max: max dcOffset: dcOffset.
		resultBuf := self copyFrom: firstPlace to: lastPlace
						normalize: nFactor dcOffset: dcOffset.
		soundSize := soundSize + resultBuf size.
"Transcript cr; print: firstPlace; space; print: lastPlace; space; print: resultBuf size; space; show: 'sound'."
		segments add: (codec == nil
			ifTrue: [SampledSound new setSamples: resultBuf samplingRate: samplingRate]
			ifFalse: [codec compressSound: (SampledSound new setSamples: resultBuf samplingRate: samplingRate)])].

	"Final gap for consistency"
	gapSize := (self copyFrom: lastPlace to: self endPlace
				normalize: 1000 dcOffset: dcOffset) size - 1.
	segments add: (RestSound dur: gapSize asFloat / samplingRate).
	restSize := restSize + gapSize.
	self inform: ((soundSize+restSize/samplingRate) roundTo: 0.1) printString , ' secs reduced to ' , ((soundSize/samplingRate) roundTo: 0.1) printString.
	recordedBuffers := nil.
	^ segments