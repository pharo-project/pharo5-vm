accessing
internalizeModulationAndRatio
	"Recompute the internal state for the modulation index and frequency ratio relative to the current pitch."

	modulation < 0.0 ifTrue: [modulation := modulation negated].
	multiplier < 0.0 ifTrue: [multiplier := multiplier negated].
	normalizedModulation :=
		((modulation * scaledIndexIncr)  / ScaleFactor) asInteger.
	scaledOffsetIndexIncr := (multiplier * scaledIndexIncr) asInteger.

	"clip to maximum values if necessary"
	normalizedModulation > MaxScaledValue ifTrue: [
		normalizedModulation := MaxScaledValue.
		modulation := (normalizedModulation * ScaleFactor) asFloat / scaledIndexIncr].
	scaledOffsetIndexIncr > (scaledWaveTableSize // 2) ifTrue: [
		scaledOffsetIndexIncr := scaledWaveTableSize // 2.
		multiplier := scaledOffsetIndexIncr asFloat / scaledIndexIncr].
