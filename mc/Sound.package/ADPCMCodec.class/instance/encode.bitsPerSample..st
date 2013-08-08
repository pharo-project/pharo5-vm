private
encode: aSoundBuffer bitsPerSample: bits

	^ self
		encodeLeft: aSoundBuffer
		right: nil
		bitsPerSample: bits
		frameSize: 0
		forFlash: false
