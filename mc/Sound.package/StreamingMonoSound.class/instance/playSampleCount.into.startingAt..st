playing
playSampleCount: n into: aSoundBuffer startingAt: startIndex
	"Mix the next n samples of this sound into the given buffer starting at the given index"

	self repeat ifTrue: [  "loop if necessary"
		(totalSamples - self currentSampleIndex) < n ifTrue: [self startOver]].

	mutex critical: [
		lastBufferMSecs := Time millisecondClockValue.
		self loadBuffersForSampleCount: (n * streamSamplingRate) // SoundPlayer samplingRate.
		mixer playSampleCount: n into: aSoundBuffer startingAt: startIndex].
