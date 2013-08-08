codec stuff
bytesPerEncodedFrame
	"Answer the number of bytes required to hold one frame of compressed sound data."
	"Note: When used as a normal codec, the frame size is always 8 samples which results in (8 * bitsPerSample) / 8 = bitsPerSample bytes."

	| bitCount |
	frameSizeMask = 0 ifTrue: [^ bitsPerSample].
	"Following assumes mono:"
	bitCount := 16 + 6 + ((self samplesPerFrame - 1) * bitsPerSample).
	^ (bitCount + 7) // 8
