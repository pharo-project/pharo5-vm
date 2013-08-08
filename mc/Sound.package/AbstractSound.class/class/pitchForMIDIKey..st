utilities
pitchForMIDIKey: midiKey
	"Answer the pitch for the given MIDI key."
	"(1 to: 127) collect: [:i | AbstractSound pitchForMIDIKey: i]"

	| indexInOctave octave |
	indexInOctave := (midiKey \\ 12) + 1.
	octave := (midiKey // 12) + 1.
	^ (PitchesForBottomOctave at: indexInOctave) *
		(#(1.0 2.0 4.0 8.0 16.0 32.0 64.0 128.0 256.0 512.0 1024.0) at: octave)
