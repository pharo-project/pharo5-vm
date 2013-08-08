sound generation
mixSampleCount: n into: aSoundBuffer startingAt: startIndex leftVol: leftVol rightVol: rightVol
	"Mix the given number of samples with the samples already in the given buffer starting at the given index. Assume that the buffer size is at least (index + count) - 1. The leftVol and rightVol parameters determine the volume of the sound in each channel, where 0 is silence and ScaleFactor is full volume."

	self subclassResponsibility.
