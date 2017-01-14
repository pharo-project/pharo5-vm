cog jit support
freeStart: aValue
	self assert: (aValue >= scavenger eden start and: [aValue < (scavengeThreshold + 1024)]).
	self assert: (scavengeThreshold max: aValue) + coInterpreter interpreterAllocationReserveBytes <= scavenger eden limit.
	^freeStart := aValue