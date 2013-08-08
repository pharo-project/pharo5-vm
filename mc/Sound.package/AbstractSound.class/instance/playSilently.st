playing
playSilently
	"Compute the samples of this sound without outputting them. Used for performance analysis."

	| bufSize buf |
	self reset.
	bufSize := self samplingRate // 10.
	buf := SoundBuffer newStereoSampleCount: bufSize.
	[self samplesRemaining > 0] whileTrue: [
		buf primFill: 0.
		self playSampleCount: bufSize into: buf startingAt: 1].
