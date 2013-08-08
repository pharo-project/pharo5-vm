other
appendSamples: aSoundBuffer
	"Append the given SoundBuffer to my stream."

	| swapBytes s |
	(stream isKindOf: StandardFileStream) ifTrue: [
		"optimization: write sound buffer directly to file"
		swapBytes := SmalltalkImage current  isLittleEndian.
		swapBytes ifTrue: [aSoundBuffer reverseEndianness].  "make big endian"
		stream next: (aSoundBuffer size // 2) putAll: aSoundBuffer startingAt: 1.  "size in words"
		swapBytes ifTrue: [aSoundBuffer reverseEndianness].  "revert to little endian"
		^ self].

	"for non-file streams:"
	s := WriteStream on: (ByteArray new: 2 * aSoundBuffer monoSampleCount).
	1 to: aSoundBuffer monoSampleCount do: [:i | s int16: (aSoundBuffer at: i)].
	self appendBytes: s contents.
