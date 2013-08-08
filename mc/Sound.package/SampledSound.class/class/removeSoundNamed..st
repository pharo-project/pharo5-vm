sound library
removeSoundNamed: aString
	"Remove the sound with the given name from the sound library."

	SoundLibrary removeKey: aString ifAbsent: [].
