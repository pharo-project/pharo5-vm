initialization
setSound: aSound iterations: anIntegerOrSymbol
	"Initialize the receiver to play the given sound the given number of times. If iteration count is the symbol #forever, then repeat indefinitely."
	"(RepeatingSound repeat: AbstractSound scaleTest count: 2) play"
	"(RepeatingSound repeatForever: PluckedSound lowMajorScale) play"

	super initialize.
	sound := aSound.
	iterationCount := anIntegerOrSymbol.
	self reset.
