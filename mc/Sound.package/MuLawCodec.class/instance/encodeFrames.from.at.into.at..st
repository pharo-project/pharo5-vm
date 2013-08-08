subclass responsibility
encodeFrames: frameCount from: srcSoundBuffer at: srcIndex into: dstByteArray at: dstIndex
	"Encode the given number of frames starting at the given index in the given monophonic SoundBuffer and storing the encoded sound data into the given ByteArray starting at the given destination index. Encode only as many complete frames as will fit into the destination. Answer a pair containing the number of samples consumed and the number of bytes of compressed data produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	srcIndex to: srcIndex + frameCount - 1 do: [:i |
		dstByteArray at: i put: (self uLawEncodeSample: (srcSoundBuffer at: i))].
	^ Array with: frameCount with: frameCount
