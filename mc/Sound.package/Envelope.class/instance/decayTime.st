accessing
decayTime
	"Return the time taken by the decay phase."

	^ points last x - (points at: loopEndIndex) x
