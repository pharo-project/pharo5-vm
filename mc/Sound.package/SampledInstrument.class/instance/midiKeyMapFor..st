other
midiKeyMapFor: sortedNotes
	"Return a 128 element array that maps each MIDI key number to the sampled note from the given set with the closests pitch. A precise match isn't necessary because the selected note will be pitch shifted to play at the correct pitch."

	^ (0 to: 127) collect: [:k |
		self
			chooseSamplesForPitch: (AbstractSound pitchForMIDIKey: k)
			from: sortedNotes].
