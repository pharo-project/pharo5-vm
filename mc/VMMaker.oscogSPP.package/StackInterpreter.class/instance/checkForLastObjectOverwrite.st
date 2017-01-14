simulation
checkForLastObjectOverwrite
	<doNotGenerate>
	| freeStart |
	checkAllocFiller ifTrue: 
		[self assert: ((freeStart := objectMemory freeStart) >= objectMemory scavengeThreshold
					  or: [(objectMemory longAt: freeStart) = freeStart])]