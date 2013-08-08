private
currentSampleIndex
	"Answer the index of the current sample."

	| bytePosition frameIndex |
	bytePosition := stream position - audioDataStart.
	codec
		ifNil: [^ bytePosition // 2]
		ifNotNil: [
			frameIndex := bytePosition // codec bytesPerEncodedFrame.
			^ (frameIndex * codec samplesPerFrame) - leftoverSamples monoSampleCount].
