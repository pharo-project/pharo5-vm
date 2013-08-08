initialization
soundForMidiKey: midiKey dur: d loudness: l
	"Answer an initialized sound object (a copy of the receiver) that generates a note for the given MIDI key (in the range 0..127), duration (in seconds), and loudness (in the range 0.0 to 1.0)."

	^ self copy
		setPitch: (AbstractSound pitchForMIDIKey: midiKey)
		dur: d
		loudness: l
