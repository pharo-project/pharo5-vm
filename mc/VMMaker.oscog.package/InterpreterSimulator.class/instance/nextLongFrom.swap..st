initialization
nextLongFrom: aStream swap: swapFlag
	swapFlag 
		ifTrue: [^ self byteSwapped: (self nextLongFrom: aStream)]
		ifFalse: [^ self nextLongFrom: aStream]