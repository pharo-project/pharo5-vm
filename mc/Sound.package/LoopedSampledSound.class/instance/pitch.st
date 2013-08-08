accessing
pitch

	^ (scaledIndexIncr asFloat * perceivedPitch * self samplingRate asFloat) /
	  (originalSamplingRate * FloatLoopIndexScaleFactor)
