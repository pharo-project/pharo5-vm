playing
playSampleCount: n into: aSoundBuffer startingAt: startIndex
	"Mix the next n samples of this sound into the given buffer starting at the given index. Update the receiver's control parameters periodically."

	| fullVol samplesBetweenControlUpdates pastEnd i remainingSamples count |
	fullVol := AbstractSound scaleFactor.
	samplesBetweenControlUpdates := self samplingRate // self controlRate.
	pastEnd := startIndex + n.  "index just after the last sample"
	i := startIndex.
	[i < pastEnd] whileTrue: [
		remainingSamples := self samplesRemaining.
		remainingSamples <= 0 ifTrue: [^ self].
		count := pastEnd - i.
		samplesUntilNextControl < count ifTrue: [count := samplesUntilNextControl].
		remainingSamples < count ifTrue: [count := remainingSamples].
		self mixSampleCount: count into: aSoundBuffer startingAt: i leftVol: fullVol rightVol: fullVol.
		samplesUntilNextControl := samplesUntilNextControl - count.
		samplesUntilNextControl <= 0 ifTrue: [
			self doControl.
			samplesUntilNextControl := samplesBetweenControlUpdates].
		i := i + count].
