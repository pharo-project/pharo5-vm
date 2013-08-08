sound generation
doControl
	"Update the control parameters of this sound using its envelopes, if any."
	"Note: This is only called at a small fraction of the sampling rate."

	| pitchModOrRatioChange |
	envelopes size > 0 ifTrue: [
		pitchModOrRatioChange := false.
		1 to: envelopes size do: [:i |
			((envelopes at: i) updateTargetAt: mSecsSinceStart)
				ifTrue: [pitchModOrRatioChange := true]].
		pitchModOrRatioChange ifTrue: [self internalizeModulationAndRatio]].
	mSecsSinceStart := mSecsSinceStart + (1000 // self controlRate).
