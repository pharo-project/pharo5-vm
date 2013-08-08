api
scavengeLoop
	"This is the inner loop of the main routine, scavenge.  It first scavenges the new objects immediately
	 reachable from old ones. Then it scavenges those that are transitively reachable.  If this results in a
	 promotion, the promotee gets remembered, and it first scavenges objects adjacent to the promotee,
	 then scavenges the ones reachable from the promoted.  This loop continues until no more reachable
	 objects are left.  At that point, pastSurvivorSpace is exchanged with futureSurvivorSpace.

	 Notice that each pointer in a live object is inspected once and only once.  The previousRememberedSetSize
	 and previousFutureSurvivorSpaceLimit variables ensure that no object is scanned twice, as well as
	 detecting closure.  If this were not true, some pointers might get forwarded twice."

	| previousRememberedSetSize previousFutureSurvivorSpaceLimit |
	previousRememberedSetSize := 0.
	previousFutureSurvivorSpaceLimit := futureSpace limit.
	self assert: futureSpace limit = futureSpace start.
	[self scavengeRememberedSetStartingAt: previousRememberedSetSize.
	 previousFutureSurvivorSpaceLimit = futureSpace limit ifTrue:
		[^self].
		
	 previousRememberedSetSize := rememberedSetSize.
	 self scavengeFutureSurvivorSpaceStartingAt: previousFutureSurvivorSpaceLimit.
	 previousFutureSurvivorSpaceLimit = rememberedSetSize ifTrue:
		[^self].

	 previousFutureSurvivorSpaceLimit := futureSpace size] repeat