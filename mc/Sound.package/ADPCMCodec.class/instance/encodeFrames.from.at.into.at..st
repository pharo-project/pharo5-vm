codec stuff
encodeFrames: frameCount from: srcSoundBuffer at: srcIndex into: dstByteArray at: dstIndex
	"Encode the given number of frames starting at the given index in the given monophonic SoundBuffer and storing the encoded sound data into the given ByteArray starting at the given destination index. Encode only as many complete frames as will fit into the destination. Answer a pair containing the number of samples consumed and the number of bytes of compressed data produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	samples := srcSoundBuffer.
	sampleIndex := srcIndex - 1.
	encodedBytes := dstByteArray.
	byteIndex := dstIndex - 1.
	bitPosition := 0.
	currentByte := 0.
	self privateEncodeMono: (frameCount * self samplesPerFrame).
	^ Array with: frameCount with: (byteIndex - (dstIndex - 1))
