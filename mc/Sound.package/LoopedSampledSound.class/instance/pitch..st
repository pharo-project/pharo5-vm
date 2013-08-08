accessing
pitch: p

	scaledIndexIncr :=
		((p asFloat * originalSamplingRate * FloatLoopIndexScaleFactor) /
		 (perceivedPitch * self samplingRate asFloat)) asInteger.

	sampleCountForRelease > 0
		ifTrue: [releaseCount := (sampleCountForRelease * LoopIndexScaleFactor) // scaledIndexIncr]
		ifFalse: [releaseCount := 0].
