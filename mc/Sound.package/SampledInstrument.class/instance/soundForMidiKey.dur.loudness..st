playing
soundForMidiKey: midiKey dur: d loudness: l
	"Answer an initialized sound object that generates a note for the given MIDI key (in the range 0..127), duration (in seconds), and loudness (in the range 0.0 to 1.0)."

	| keymap note |
	l >= loudThreshold
		ifTrue: [
			d >= sustainedThreshold
				ifTrue: [keymap := sustainedLoud]
				ifFalse: [keymap := staccatoLoud]]
		ifFalse: [
			d >= sustainedThreshold
				ifTrue: [keymap := sustainedSoft]
				ifFalse: [keymap := staccatoSoft]].
	keymap ifNil: [keymap := sustainedLoud].
	note := (keymap at: midiKey) copy.
	^ note
		setPitch: (AbstractSound pitchForMIDIKey: midiKey)
		dur: d
		loudness: (l * note gain)
