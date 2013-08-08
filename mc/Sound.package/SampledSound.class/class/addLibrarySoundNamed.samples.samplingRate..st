sound library
addLibrarySoundNamed: aString samples: sampleData samplingRate: samplesPerSecond
	"Add the given sound to the sound library. The sample data may be either a ByteArray or a SoundBuffer. If the former, it is take to be 8-bit unsigned samples. If the latter, it is taken to be 16 bit signed samples."

	SoundLibrary
		at: aString
		put: (Array with: sampleData with: samplesPerSecond).
