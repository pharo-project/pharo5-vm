private
loadBuffer: aSoundBuffer uncompressedSampleCount: sampleCount
	"Load the given sound buffer from the uncompressed sample stream."

	"read directly into the sample buffer; count is in 32-bit words"
	stream next: sampleCount // 2 into: aSoundBuffer startingAt: 1.
	aSoundBuffer restoreEndianness.

	"read the final sample if sampleCount is odd:"
	sampleCount odd ifTrue: [aSoundBuffer at: sampleCount put: stream int16].
