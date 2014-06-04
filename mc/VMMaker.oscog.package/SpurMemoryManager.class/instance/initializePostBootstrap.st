spur bootstrap
initializePostBootstrap
	"The heap has just been bootstrapped into a modified newSpace occupying all of memory
	 above newSpace (and the codeZone). Put things back to some kind of normalcy."
	freeOldSpaceStart := freeStart.
	freeStart := scavenger eden start.
	pastSpaceStart := scavenger pastSpace start.
	scavengeThreshold := scavenger eden limit - (scavenger edenBytes // 64)