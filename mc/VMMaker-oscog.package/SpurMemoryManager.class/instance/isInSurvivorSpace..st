object testing
isInSurvivorSpace: objOop
	^objOop >= scavenger pastSpace start
	  and: [objOop < pastSpaceStart]