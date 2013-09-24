object testing
isInFutureSpace: objOop
	^objOop >= scavenger futureSpace start
	  and: [objOop < scavenger futureSurvivorStart]