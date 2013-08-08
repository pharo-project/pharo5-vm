initialization
setPitch: pitchNameOrNumber dur: d loudness: vol
	"(FMSound pitch: 'a4' dur: 2.5 loudness: 0.4) play"

	super setPitch: pitchNameOrNumber dur: d loudness: vol.
	modulation ifNil: [modulation := 0.0].
	multiplier ifNil: [multiplier := 0.0].
	self pitch: (self nameOrNumberToPitch: pitchNameOrNumber).
	self reset.
