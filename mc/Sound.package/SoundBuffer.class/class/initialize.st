initialization
initialize
	"Build a sine wave table."
	"SoundBuffer initialize"

	| tableSize radiansPerStep peak |
	tableSize := 4000.
	SineTable := self newMonoSampleCount: tableSize.
	radiansPerStep := (2.0 * Float pi) / tableSize asFloat.
	peak := ((1 bitShift: 15) - 1) asFloat.  "range is +/- (2^15 - 1)"
	1 to: tableSize do: [:i |
		SineTable at: i put: (peak * (radiansPerStep * (i - 1)) sin) rounded].
