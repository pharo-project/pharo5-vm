private
decodeFlash: aByteArray sampleCount: sampleCount stereo: stereoFlag

	| bits |
	encodedBytes := aByteArray.
	byteIndex := 0.
	bitPosition := 0.
	currentByte := 0.
	bits := 2 + (self nextBits: 2).  "bits per sample"
	self initializeForBitsPerSample: bits samplesPerFrame: 4096.
	stereoFlag
		ifTrue: [
			self resetForStereo.
			samples := SoundBuffer newMonoSampleCount: sampleCount.
			rightSamples := SoundBuffer newMonoSampleCount: sampleCount.
			sampleIndex := 0.
			self privateDecodeStereo: sampleCount.
			^ Array with: samples with: rightSamples]
		ifFalse: [
			samples := SoundBuffer newMonoSampleCount: sampleCount.
			sampleIndex := 0.
			self privateDecodeMono: sampleCount.
			^ Array with: samples].
