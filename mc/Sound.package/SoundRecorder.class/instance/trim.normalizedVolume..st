trimming
trim: threshold normalizedVolume: percentOfMaxVolume
	"Remove the leading and trailing parts of this recording that are below the given threshold. Remove any DC offset and scale the recording so that its peaks are the given percent of the maximum volume."

	| dcOffset startPlace endPlace resultBuf nFactor max min sum totalSamples |
	stereo ifTrue: [self error: 'stereo trimming is not yet supported'].
	paused ifFalse: [self error: 'must stop recording before trimming'].
	recordedBuffers := recordedSound sounds collect: [:snd | snd samples].
	recordedBuffers isEmpty ifTrue: [^ self].

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

	"a place is an array of <buffer index><index of sample in buffer>"
	startPlace := self scanForStartThreshold: threshold
					dcOffset: dcOffset
					minDur: (samplingRate/60.0) asInteger "at least 1/60th of a second"
					startingAt: #(1 1).
	startPlace = self endPlace ifTrue:
		["no samples above threshold"
		recordedBuffers := nil.  ^ self].

	endPlace := self scanForEndThreshold: threshold
					dcOffset: dcOffset
					minLull: (samplingRate/5) asInteger
					startingAt: startPlace.
	nFactor := self normalizeFactorFor: percentOfMaxVolume min: min max: max dcOffset: dcOffset.
	resultBuf := self copyFrom: startPlace to: endPlace normalize: nFactor dcOffset: dcOffset.
	recordedSound := SampledSound new setSamples: resultBuf samplingRate: samplingRate.
	recordedBuffers := nil
