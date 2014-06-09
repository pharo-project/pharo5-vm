accessing
getScavengeThreshold
	^objectMemory getScavengeThreshold ifNil: [16r24680]