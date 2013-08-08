private
encodeLeft: leftSoundBuffer right: rightSoundBuffer bitsPerSample: bits frameSize: frameSize forFlash: flashFlag

	| stereoFlag sampleCount sampleBitCount bitCount |
	self initializeForBitsPerSample: bits samplesPerFrame: frameSize.
	stereoFlag := rightSoundBuffer notNil.
	sampleCount := leftSoundBuffer monoSampleCount.
	stereoFlag
		ifTrue: [sampleBitCount := 2 * (sampleCount * bitsPerSample)]
		ifFalse: [sampleBitCount := sampleCount * bitsPerSample].
	bitCount := sampleBitCount +
		(self headerBitsForSampleCount: sampleCount stereoFlag: stereoFlag).

	encodedBytes := ByteArray new: ((bitCount / 8) ceiling roundUpTo: self bytesPerEncodedFrame).
	byteIndex := 0.
	bitPosition := 0.
	currentByte := 0.
	flashFlag ifTrue: [self nextBits: 2 put: bits - 2].
	stereoFlag
		ifTrue: [
			samples := Array with: leftSoundBuffer with: rightSoundBuffer.
			sampleIndex := Array with: 0 with: 0.
			self privateEncodeStereo: sampleCount]
		ifFalse: [
			samples := leftSoundBuffer.
			sampleIndex := 0.
			self privateEncodeMono: sampleCount].

	^ encodedBytes
