playing
soundForPitch: pitchNameOrNumber dur: d loudness: l
	"Answer an initialized sound object that generates a note of the given pitch, duration, and loudness. Pitch may be a numeric pitch or a string pitch name such as 'c4'. Duration is in seconds and loudness is in the range 0.0 to 1.0."
	"Note:  Generally, SampledInstruments are expected to be played via MIDI key numbers rather than by pitches, since finding the MIDI key for a given pitch is expensive."

	^ self soundForMidiKey: (AbstractSound midiKeyForPitch: pitchNameOrNumber)
		dur: d
		loudness: l
