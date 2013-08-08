private
decode: aByteArray sampleCount: count bitsPerSample: bits frameSize: frameSize stereo: stereoFlag

	self initializeForBitsPerSample: bits samplesPerFrame: frameSize.
	encodedBytes := aByteArray.
	byteIndex := 0.
	bitPosition := 0.
	currentByte := 0.
	stereoFlag
		ifTrue: [
			self resetForStereo.
			samples := SoundBuffer newMonoSampleCount: count.
			rightSamples := SoundBuffer newMonoSampleCount: count.
			sampleIndex := 0.
			self privateDecodeStereo: count.
			^ Array with: samples with: rightSamples]
		ifFalse: [
			samples := SoundBuffer newMonoSampleCount: count.
			sampleIndex := 0.
			self privateDecodeMono: count.
			^ samples]
