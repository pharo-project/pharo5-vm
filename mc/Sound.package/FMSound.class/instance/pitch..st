accessing
pitch: p
	"Warning: Since the modulation and ratio are relative to the current pitch, some internal state must be recomputed when the pitch is changed. However, for efficiency during envelope processing, this compuation will not be done until internalizeModulationAndRatio is called."

	scaledIndexIncr :=
		((p asFloat * waveTable size asFloat * ScaleFactor asFloat) / self samplingRate asFloat) asInteger
			min: (waveTable size // 2) * ScaleFactor.
