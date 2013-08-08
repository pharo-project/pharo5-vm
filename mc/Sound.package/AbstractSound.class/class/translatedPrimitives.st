primitive generation
translatedPrimitives
	^#(
		(FMSound mixSampleCount:into:startingAt:leftVol:rightVol:)
		(PluckedSound mixSampleCount:into:startingAt:leftVol:rightVol:)
		(LoopedSampledSound mixSampleCount:into:startingAt:leftVol:rightVol:)
		(SampledSound mixSampleCount:into:startingAt:leftVol:rightVol:)
		(ReverbSound applyReverbTo:startingAt:count:)
	).
