utilities
midiKeyForPitch: pitchNameOrNumber
	"Answer the midiKey closest to the given pitch. Pitch may be a numeric pitch or a pitch name string such as 'c4'."
	"AbstractSound midiKeyForPitch: 440.0"

	| p octave i midiKey |
	pitchNameOrNumber isNumber
		ifTrue: [p := pitchNameOrNumber asFloat]
		ifFalse: [p := AbstractSound pitchForName: pitchNameOrNumber].
	octave := -1.
	[p >= TopOfBottomOctave] whileTrue: [
		octave := octave + 1.
		p := p / 2.0].

	i := self indexOfBottomOctavePitch: p.
	(i > 1) ifTrue: [
		(p - (PitchesForBottomOctave at: i - 1)) < ((PitchesForBottomOctave at: i) - p)
			ifTrue: [i := i - 1]].

	midiKey := ((octave * 12) + 11 + i).
	midiKey > 127 ifTrue: [midiKey := 127].
	^ midiKey
