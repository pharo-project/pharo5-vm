accessing
getScavengeThreshold
	^variables
		at: 'scavengeThreshold'
		ifAbsentPut: [objectMemory getScavengeThreshold ifNil: [16r24680]]