gc - scavenging
newSpaceIsEmpty
	^freeStart = scavenger eden start
	  and: [pastSpaceStart = scavenger pastSpace start]