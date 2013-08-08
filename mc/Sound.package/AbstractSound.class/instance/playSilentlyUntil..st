playing
playSilentlyUntil: startTime
	"Compute the samples of this sound without outputting them. Used to fast foward to a particular starting time. The start time is given in seconds."

	| buf startSample nextSample samplesRemaining n |
	self reset.
	buf := SoundBuffer newStereoSampleCount: (self samplingRate // 10).
	startSample := (startTime * self samplingRate) asInteger.
	nextSample := 1.
	[self samplesRemaining > 0] whileTrue: [
		nextSample >= startSample ifTrue: [^ self].
		samplesRemaining := startSample - nextSample.
		samplesRemaining > buf stereoSampleCount
			ifTrue: [n := buf stereoSampleCount]
			ifFalse: [n := samplesRemaining].
		self playSampleCount: n into: buf startingAt: 1.
		nextSample := nextSample + n].
