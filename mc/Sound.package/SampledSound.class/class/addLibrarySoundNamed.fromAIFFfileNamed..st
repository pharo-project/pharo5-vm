sound library
addLibrarySoundNamed: aString fromAIFFfileNamed: fileName
	"Add a sound from the given AIFF file to the library."
	"SampledSound
		addLibrarySoundNamed: 'shutterClick'
		fromAIFFfileNamed: '7.aif'"
	"Add all .aif files in the current directory to the sound library:
	| fileNames |
	fileNames := FileDirectory default fileNamesMatching: '*.aif'.
	fileNames do: [:fName |
		SampledSound
			addLibrarySoundNamed: (fName copyUpTo: $.)
			fromAIFFfileNamed: fName]"

	| snd |
	snd := self fromAIFFfileNamed: fileName.
	self addLibrarySoundNamed: aString
		samples: snd samples
		samplingRate: snd originalSamplingRate.
