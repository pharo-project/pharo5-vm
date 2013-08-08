other
sound
	"Answer the sound represented by this AIFFFileReader. This method should be called only after readFrom: has been done."

	| snd rightSnd |
	snd := SampledSound
		samples: (channelData at: 1)
		samplingRate: samplingRate.
	self isStereo ifTrue: [
		rightSnd := SampledSound
			samples: (channelData at: 2)
			samplingRate: samplingRate.
		snd := MixedSound new
			add: snd pan: 0;
			add: rightSnd pan: 1.0].
	^ snd
