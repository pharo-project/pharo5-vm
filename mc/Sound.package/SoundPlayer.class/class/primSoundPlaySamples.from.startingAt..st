private
primSoundPlaySamples: count from: aSampleBuffer startingAt: index
	"Copy count bytes into the current sound output buffer from the given sample buffer starting at the given index."

	<primitive: 'primitiveSoundPlaySamples' module: 'SoundPlugin'>
	^ self primitiveFailed
