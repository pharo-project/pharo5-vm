utilities
saveAsAIFFFileSamplingRate: rate on: aBinaryStream
	"Store this mono sound buffer in AIFF file format with the given sampling rate on the given stream."

	| sampleCount s swapBytes |
	sampleCount := self monoSampleCount.
	aBinaryStream nextPutAll: 'FORM' asByteArray.
	aBinaryStream nextInt32Put: (2 * sampleCount) + ((7 * 4) + 18).
	aBinaryStream nextPutAll: 'AIFF' asByteArray.
	aBinaryStream nextPutAll: 'COMM' asByteArray.
	aBinaryStream nextInt32Put: 18.
	aBinaryStream nextNumber: 2 put: 1.  "channels"
	aBinaryStream nextInt32Put: sampleCount.
	aBinaryStream nextNumber: 2 put: 16.  "bits/sample"
	self storeExtendedFloat: rate on: aBinaryStream.
	aBinaryStream nextPutAll: 'SSND' asByteArray.
	aBinaryStream nextInt32Put: (2 * sampleCount) + 8.
	aBinaryStream nextInt32Put: 0.
	aBinaryStream nextInt32Put: 0.

	(aBinaryStream isKindOf: StandardFileStream) ifTrue: [
		"optimization: write sound buffer directly to file"
		swapBytes := SmalltalkImage current  isLittleEndian.
		swapBytes ifTrue: [self reverseEndianness].  "make big endian"
		aBinaryStream next: (self size // 2) putAll: self startingAt: 1.  "size in words"
		swapBytes ifTrue: [self reverseEndianness].  "revert to little endian"
		^ self].

	1 to: sampleCount do: [:i |
		s := self at: i.
		aBinaryStream nextPut: ((s bitShift: -8) bitAnd: 16rFF).
		aBinaryStream nextPut: (s bitAnd: 16rFF)].
