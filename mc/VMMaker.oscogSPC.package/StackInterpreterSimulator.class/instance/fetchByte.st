interpreter shell
fetchByte
	^objectMemory byteAt: (localIP := localIP + 1).