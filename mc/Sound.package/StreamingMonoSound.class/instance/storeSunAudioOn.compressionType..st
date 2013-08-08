converting
storeSunAudioOn: aBinaryStream compressionType: compressionName
	"Store myself on the given stream as a monophonic sound compressed with the given type of compression. The sampling rate is reduced to 22050 samples/second if it is higher."

	| fmt inBufSize samplesPerFrame outCodec compressed outSamplingRate audioWriter |
	self pause; reset.  "stop playing and return to beginning"

	fmt := SunAudioFileWriter formatCodeForCompressionType: compressionName.
	inBufSize := 64000.
	samplesPerFrame := 1.
	outCodec := SunAudioFileWriter codecForFormatCode: fmt.
	outCodec ifNotNil: [
		samplesPerFrame := outCodec samplesPerFrame.
		inBufSize := inBufSize roundUpTo: (2 * samplesPerFrame).
		compressed := ByteArray new:
			(inBufSize // samplesPerFrame) * outCodec bytesPerEncodedFrame].
	outSamplingRate := streamSamplingRate.
	streamSamplingRate > 22050 ifTrue: [
		streamSamplingRate = 44100 ifFalse: [self error: 'unexpected MP3 sampling rate'].
		outSamplingRate := 22050].

	"write audio header"
	audioWriter := SunAudioFileWriter onStream: aBinaryStream.
	audioWriter writeHeaderSamplingRate: outSamplingRate format: fmt.

	"convert and write sound data"
	'Storing audio...' displayProgressAt: Sensor cursorPoint
		from: 0 to: totalSamples during: [:bar | | outBuf counts inBuf samplesRemaining byteCount |
			samplesRemaining := totalSamples.
			[samplesRemaining > 0] whileTrue: [
				bar value: totalSamples - samplesRemaining.
				self loadBuffersForSampleCount: (inBufSize min: samplesRemaining).
				inBuf := mixer sounds first samples.
				outSamplingRate < streamSamplingRate
					ifTrue: [outBuf := inBuf downSampledLowPassFiltering: true]
					ifFalse: [outBuf := inBuf].
				outCodec
					ifNil: [audioWriter appendSamples: outBuf]
					ifNotNil: [
						counts := outCodec
							encodeFrames: (outBuf size // samplesPerFrame)
							from: outBuf at: 1
							into: compressed at: 1.
						byteCount := counts last.
						byteCount = compressed size
							ifTrue: [audioWriter appendBytes: compressed]
							ifFalse: [audioWriter appendBytes: (compressed copyFrom: 1 to: byteCount)]].
				samplesRemaining := samplesRemaining - inBuf monoSampleCount]].

	"update audio header"
	audioWriter updateHeaderDataSize.
