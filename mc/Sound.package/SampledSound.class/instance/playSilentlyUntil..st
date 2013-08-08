playing
playSilentlyUntil: startTime
	"Used to fast foward to a particular starting time.
	Overridden to be instant for sampled sounds."

"true ifTrue: [^ super playSilentlyUntil: startTime]."
	indexHighBits := (startTime * originalSamplingRate) asInteger.
	scaledIndex := IncrementScaleFactor.
	count := initialCount - (startTime * self samplingRate).
	mSecsSinceStart := (startTime * 1000) asInteger.

