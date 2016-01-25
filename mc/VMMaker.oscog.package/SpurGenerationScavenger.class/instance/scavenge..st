scavenger
scavenge: tenuringCriterion
	"The main routine, scavenge, scavenges young objects reachable from the roots (the stack zone
	 and the rememberedTable).  It first scavenges the new objects immediately reachable from old
	 ones (all in the remembered table), then the stack zone.  Then it scavenges those that are
	 transitively reachable.  If this results in a promotion, the promotee gets remembered, and it first
	 scavenges objects adjacent to the promotee, then scavenges the ones reachable from the
	 promoted.  This loop continues until no more reachable objects are left.  At that point,
	 pastSurvivorSpace is exchanged with futureSurvivorSpace.  Then any surviving weakArrays and
	 weakArrays in the remembered set can be processed and their dead elements nilled.

	 By default promotion (tenuring) is based on age and ammount of objects scavenged.  But
	 tenuring can be based on e.g. a particular class.  The argument selects the tenuring criterion.

	 Answer the limit of pastSpace, to allow the memory manager to bounds check survivors."
	statSurvivorCount := 0.
	tenureCriterion := tenuringCriterion.
	self strategizeToLimitRememberedTable.
	self scavengeLoop.
	self processWeaklings.
	self computeTenuringThreshold.
	self exchangeSurvivorSpaces.
	^self initFutureSpaceStart