playing
computeSamplesForSeconds: seconds
	"Compute the samples of this sound without outputting them, and return the resulting buffer of samples."

	| buf |
	self reset.
	buf := SoundBuffer newStereoSampleCount: (self samplingRate * seconds) asInteger.
	self playSampleCount: buf stereoSampleCount into: buf startingAt: 1.
	^ buf
