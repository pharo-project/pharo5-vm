initialization
fromAIFFFileReader: aiffFileReader mergeIfStereo: mergeFlag
	"Initialize this sound from the data in the given AIFF file. If mergeFlag is true and the file is stereo, its left and right channels are mixed together to produce a mono sampled sound."

	aiffFileReader isLooped
		ifTrue: [
			self samples: aiffFileReader leftSamples
				loopEnd: aiffFileReader loopEnd
				loopLength: aiffFileReader loopLength
				pitch: aiffFileReader pitch
				samplingRate: aiffFileReader samplingRate]
		ifFalse: [
			self unloopedSamples: aiffFileReader leftSamples
				pitch: aiffFileReader pitch
				samplingRate: aiffFileReader samplingRate].

	"the following must be done second, since the initialization above sets
	 leftSamples and rightSamples to the same sample data"
	aiffFileReader isStereo
		ifTrue: [rightSamples := aiffFileReader rightSamples].

	initialCount := (leftSamples size * self samplingRate) // originalSamplingRate.
	self loudness: 1.0.

	self addReleaseEnvelope.
