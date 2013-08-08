playing
playSoundNamed: soundName
	"There is sound support, so we play the given sound."

	SoundService soundEnabled ifTrue: [
		SampledSound playSoundNamed: soundName asString]