allocation
bytesLeft: includingSwap
	^self freeSize + (self sqMemoryExtraBytesLeft: includingSwap)