interpreter shell
fetchByte

	^ self byteAt: (localIP := localIP + 1).