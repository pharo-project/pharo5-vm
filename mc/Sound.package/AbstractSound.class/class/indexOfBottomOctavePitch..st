utilities
indexOfBottomOctavePitch: p
	"Answer the index of the first pitch in the bottom octave equal to or higher than the given pitch. Assume that the given pitch is below the top pitch of the bottom octave."

	1 to: PitchesForBottomOctave size do: [:i |
		(PitchesForBottomOctave at: i) >= p ifTrue: [^ i]].
	self error: 'implementation error: argument pitch should be below or within the bottom octave'.
