initialization
setDur: d
	"Set rest duration in seconds."

	initialCount := (d * self samplingRate asFloat) rounded.
	count := initialCount.
	self reset.
