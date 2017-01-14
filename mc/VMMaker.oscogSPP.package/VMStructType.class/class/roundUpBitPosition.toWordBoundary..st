code generation
roundUpBitPosition: bitPosition toWordBoundary: bytesPerWord
	^bitPosition + 7 // 8 + bytesPerWord - 1 // bytesPerWord * bytesPerWord * 8