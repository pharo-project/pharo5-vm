accessing
volume: aNumber
	"Set my volume to the given number between 0.0 and 1.0."

	volume := aNumber.
	self createMixer.
