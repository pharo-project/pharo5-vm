allocation
checkForLastObjectOverwrite
	<doNotGenerate>
	self assert: (freeStart >= scavengeThreshold
				or: [(AllocationCheckFiller = 0
		  		or: [(self longAt: freeStart) = (AllocationCheckFiller = 16rADD4E55
												ifTrue: [freeStart]
												ifFalse: [AllocationCheckFiller])])])