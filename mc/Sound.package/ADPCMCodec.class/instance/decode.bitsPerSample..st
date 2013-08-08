private
decode: aByteArray bitsPerSample: bits

	^ self
		decode: aByteArray
		sampleCount: (aByteArray size * 8) // bits
		bitsPerSample: bits
		frameSize: 0
		stereo: false
