playing
playSampledSound: samples rate: rate

	SoundService soundEnabled ifTrue: [
		(SampledSound samples: samples samplingRate: rate) play]