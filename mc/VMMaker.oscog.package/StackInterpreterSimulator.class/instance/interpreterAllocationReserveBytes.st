stack pages
interpreterAllocationReserveBytes
	^bootstrapping
		ifTrue: [0]
		ifFalse: [super interpreterAllocationReserveBytes]