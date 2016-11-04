gc - scavenging
initializeNewSpaceVariables
	<inline: #never>
	freeStart := scavenger eden start.
	pastSpaceStart := scavenger pastSpace start.
	scavengeThreshold := scavenger eden limit
							- (scavenger edenBytes // 64)
							- coInterpreter interpreterAllocationReserveBytes.
	newSpaceStart := scavenger pastSpace start min: scavenger futureSpace start.
	self assert: newSpaceStart < scavenger eden start.
	self initSpaceForAllocationCheck: (self addressOf: scavenger eden) limit: scavengeThreshold