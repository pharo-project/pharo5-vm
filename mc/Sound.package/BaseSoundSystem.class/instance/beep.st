playing
beep
	"There is sound support, so we use the default
	sampled sound for a beep."

	SoundService soundEnabled ifTrue: [
		SampledSound beep]