conversion
asSampledSound
	"Answer a SampledSound containing my samples. If the receiver is some kind of sampled sound, the resulting SampledSound will have the same original sampling rate as the receiver."

	^ SampledSound samples: self samples samplingRate: self originalSamplingRate
