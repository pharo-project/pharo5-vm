primitive test
boinkPitch: p dur: d loudness: l waveTable: waveTable pan: pan
	"Play a decaying note on the given stream using the given wave table. Used for testing only."

	| decay tableSize amplitude increment cycles i |
	decay := 0.96.
	tableSize := waveTable size.
	amplitude := l asInteger min: 1000.
	increment := ((p asFloat * tableSize asFloat) / SamplingRate asFloat) asInteger.
	increment := (increment max: 1) min: (tableSize // 2).
	cycles := (d * SamplingRate asFloat) asInteger.

	i := 1.
	1 to: cycles do: [:cycle |
		(cycle \\ 100) = 0
			ifTrue: [amplitude := (decay * amplitude asFloat) asInteger].
		i := (((i - 1) + increment) \\ tableSize) + 1.
		self playTestSample: (amplitude * (waveTable at: i)) // 1000 pan: pan].
