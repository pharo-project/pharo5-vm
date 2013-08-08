subclass responsibility
decodeFrames: frameCount from: srcByteArray at: srcIndex into: dstSoundBuffer at: dstIndex
	"Decode the given number of monophonic frames starting at the given index in the given ByteArray of compressed sound data and storing the decoded samples into the given SoundBuffer starting at the given destination index. Answer a pair containing the number of bytes of compressed data consumed and the number of decompressed samples produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	| dst |
	dst := dstIndex.
	srcIndex to: srcIndex + frameCount - 1 do: [:src |
		dstSoundBuffer at: dst put: (DecodingTable at: (srcByteArray at: src) + 1).
		dst := dst + 1].
	^ Array with: frameCount with: frameCount
