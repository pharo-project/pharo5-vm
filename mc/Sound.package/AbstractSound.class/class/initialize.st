initialization
initialize
	"AbstractSound initialize"
 
	| bottomC |
	ScaleFactor := 2 raisedTo: 15.
	FloatScaleFactor := ScaleFactor asFloat.
	MaxScaledValue := ((2 raisedTo: 31) // ScaleFactor) - 1.  "magnitude of largest scaled value in 32-bits"

	"generate pitches for c-1 through c0"
	bottomC := (440.0 / 32) * (2.0 raisedTo: -9.0 / 12.0).
	PitchesForBottomOctave := (0 to: 12) collect: [:i | bottomC * (2.0 raisedTo: i asFloat / 12.0)].
	TopOfBottomOctave := PitchesForBottomOctave last.
