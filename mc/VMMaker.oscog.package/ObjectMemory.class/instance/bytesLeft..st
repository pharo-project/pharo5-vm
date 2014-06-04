allocation
bytesLeft: includingSwap
	^(self sizeOfFree: freeBlock) "already commited"
		+ (self sqMemoryExtraBytesLeft: includingSwap).