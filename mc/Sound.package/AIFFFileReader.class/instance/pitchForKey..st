other
pitchForKey: midiKey
	"Convert my MIDI key number to a pitch and return it."

	| indexInOctave octave p |
	indexInOctave := (midiKey \\ 12) + 1.
	octave := (midiKey // 12) + 1.
	"Table generator: (0 to: 11) collect: [:i | 16.3516 * (2.0 raisedTo: i asFloat / 12.0)]"
	p := #(16.3516 17.32391 18.35405 19.44544 20.60173 21.82677
		  23.12466 24.49972 25.95655 27.50000 29.13524 30.86771) at: indexInOctave.
	^ p * (#(0.5 1.0 2.0 4.0 8.0 16.0 32.0 64.0 128.0 256.0 512.0) at: octave)
