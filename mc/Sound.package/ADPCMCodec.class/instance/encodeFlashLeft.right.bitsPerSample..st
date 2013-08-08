private
encodeFlashLeft: leftSoundBuffer right: rightSoundBuffer bitsPerSample: bits

	^ self
		encodeLeft: leftSoundBuffer
		right: rightSoundBuffer
		bitsPerSample: bits
		frameSize: 4096
		forFlash: true
