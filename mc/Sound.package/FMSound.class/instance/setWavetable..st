initialization
setWavetable: anArray
	"(AbstractSound lowMajorScaleOn: (FMSound new setWavetable: AA)) play"

	| samples p dur vol |
	"copy the array into a SoundBuffer if necessary"
	anArray class isPointers
		ifTrue: [samples := SoundBuffer fromArray: anArray]
		ifFalse: [samples := anArray].

	p := self pitch.
	dur := self duration.
	vol := self loudness.
	waveTable := samples.
	scaledWaveTableSize := waveTable size * ScaleFactor.
	self setPitch: p dur: dur loudness: vol.
