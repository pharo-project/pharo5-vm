instance creation
newBitsPerSample: bitsPerSample

	^ super new
		initializeForBitsPerSample: bitsPerSample
		samplesPerFrame: 0.
