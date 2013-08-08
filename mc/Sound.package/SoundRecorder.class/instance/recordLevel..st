accessing
recordLevel: level
	"Set the desired recording level to the given value in the range 0.0 to 1.0, where 0.0 is the lowest recording level and 1.0 is the maximum. Do nothing if the sound input hardware does not support changing the recording level."
	"Details: On the Macintosh, the lowest possible record level attenuates the input signal, but does not silence it entirely." 

	recordLevel := (level asFloat min: 1.0) max: 0.0.
	recordProcess ifNotNil: [
		self primSetRecordLevel: (1000.0 * recordLevel) asInteger].
