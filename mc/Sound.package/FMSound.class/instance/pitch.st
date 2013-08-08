accessing
pitch

	^ (self samplingRate asFloat * scaledIndexIncr / ScaleFactor) asFloat / waveTable size
