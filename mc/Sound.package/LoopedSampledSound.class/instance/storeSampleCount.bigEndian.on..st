file i/o
storeSampleCount: samplesToStore bigEndian: bigEndianFlag on: aBinaryStream
	"Store my samples on the given stream at the current SoundPlayer sampling rate. If bigFlag is true, then each 16-bit sample is stored most-significant byte first (AIFF files), otherwise it is stored least-significant byte first (WAV files)."

	| reverseBytes |
	(self isStereo or: [self samplingRate ~= originalSamplingRate]) ifTrue: [
		^ super storeSampleCount: samplesToStore bigEndian: bigEndianFlag on: aBinaryStream].

	"optimization: if I'm not stereo and sampling rates match, just store my buffer"
	reverseBytes := bigEndianFlag ~= SmalltalkImage current  isBigEndian.
	reverseBytes ifTrue: [leftSamples reverseEndianness].
	(aBinaryStream isKindOf: StandardFileStream)
		ifTrue: [  "optimization for files: write sound buffer directly to file"
			aBinaryStream next: (leftSamples size // 2) putAll: leftSamples startingAt: 1]  "size in words"
		ifFalse: [  "for non-file streams:"
			1 to: leftSamples monoSampleCount do: [:i | aBinaryStream int16: (leftSamples at: i)]].
	reverseBytes ifTrue: [leftSamples reverseEndianness].  "restore to original endianness"
