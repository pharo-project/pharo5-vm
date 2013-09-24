scavenger
scavengeLoop
	"This is the inner loop of the main routine, scavenge.  It first scavenges the new objects immediately
	 reachable from old ones. Then it scavenges those that are transitively reachable.  If this results in a
	 promotion, the promotee gets remembered, and it first scavenges objects adjacent to the promotee,
	 then scavenges the ones reachable from the promoted.  This loop continues until no more reachable
	 objects are left.  At that point, pastSurvivorSpace is exchanged with futureSurvivorSpace.

	 Notice that each pointer in a live object is inspected once and only once.  The previousRememberedSetSize
	 and previousFutureSurvivorSpaceLimit variables ensure that no object is scanned twice, as well as
	 detecting closure.  If this were not true, some pointers might get forwarded twice."

	| firstTime previousRememberedSetSize previousFutureSurvivorStart |
	self assert: futureSurvivorStart = futureSpace start. "future space should be empty at the start"
	firstTime := true.
	previousRememberedSetSize := 0.
	previousFutureSurvivorStart := futureSurvivorStart.
	[self scavengeRememberedSetStartingAt: previousRememberedSetSize.
	 previousRememberedSetSize := rememberedSetSize.
	 firstTime ifTrue:
		[coInterpreter mapInterpreterOops.
		 firstTime := false].
	 "nothing more copied and forwarded (or remembered by mapInterpreterOops)
	  to scavenge so scavenge is done."
	 (previousRememberedSetSize = rememberedSetSize
	  and: [previousFutureSurvivorStart = futureSurvivorStart]) ifTrue:
		[^self].

	 self scavengeFutureSurvivorSpaceStartingAt: previousFutureSurvivorStart.
	 "no more roots created to scavenge, so scavenge is done."
	 previousRememberedSetSize = rememberedSetSize ifTrue:
		[^self].

	 previousFutureSurvivorStart := futureSurvivorStart] repeat