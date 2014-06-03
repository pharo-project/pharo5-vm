cog jit support
freeStart: aValue
	self assert: (aValue >= scavenger eden start and: [aValue < scavengeThreshold]).
	self assert: scavengeThreshold + coInterpreter interpreterAllocationReserveBytes <= scavenger eden limit.
	^freeStart := aValue