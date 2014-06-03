initialization
getLongFromFile: aStream swap: swapFlag
	^swapFlag 
		ifTrue: [objectMemory byteSwapped: (self nextLongFrom: aStream)]
		ifFalse: [self nextLongFrom: aStream]