playing
playSoundNamedOrBeep: soundName
	"There is sound support, so we play the given sound
	instead of beeping."

	SoundService soundEnabled ifTrue: [
		^self playSoundNamed: soundName]