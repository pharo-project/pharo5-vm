initialization
initFutureSpaceStart
	| oldStart |
	oldStart := futureSurvivorStart.
	futureSurvivorStart := futureSpace start.
	^oldStart