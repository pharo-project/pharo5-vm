codec stuff
decodeFrames: frameCount from: srcByteArray at: srcIndex into: dstSoundBuffer at: dstIndex
	"Decode the given number of monophonic frames starting at the given index in the given ByteArray of compressed sound data and storing the decoded samples into the given SoundBuffer starting at the given destination index. Answer a pair containing the number of bytes of compressed data consumed and the number of decompressed samples produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	encodedBytes := srcByteArray.
	byteIndex := srcIndex - 1.
	bitPosition := 0.
	currentByte := 0.
	samples := dstSoundBuffer.
	sampleIndex := dstIndex - 1.
	self privateDecodeMono: (frameCount * self samplesPerFrame).
	^ Array with: (byteIndex - (srcIndex - 1)) with: (sampleIndex - (dstIndex - 1))
