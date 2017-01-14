generate machine code
computeSizeOfPushCw
	^(self inCurrentCompilation: (operands at: 0))
		ifTrue: [9]
		ifFalse: [self pushCwByteSize]