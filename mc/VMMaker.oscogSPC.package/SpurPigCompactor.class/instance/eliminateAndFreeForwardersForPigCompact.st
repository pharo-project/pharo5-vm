compaction
eliminateAndFreeForwardersForPigCompact
	"As the final phase of global garbage collect, sweep the heap to follow
	 forwarders, then free forwarders, coalescing with free space as we go."
	<inline: false>
	| lowestForwarder |
	<var: #lowestForwarder type: #usqInt>
	self assert: (manager isForwarded: manager nilObject) not.
	self assert: (manager isForwarded: manager falseObject) not.
	self assert: (manager isForwarded: manager trueObject) not.
	self assert: (manager isForwarded: manager freeListsObj) not.
	self assert: (manager isForwarded: manager hiddenRootsObject) not.
	self assert: (manager isForwarded: manager classTableFirstPage) not.
	manager followSpecialObjectsOop.
	manager followForwardedObjStacks.
	coInterpreter mapInterpreterOops.
	scavenger followRememberedForwardersAndForgetFreeObjectsForPigCompact.
	manager unmarkSurvivingObjectsForCompact.
	lowestForwarder := self sweepToFollowForwardersForPigCompact.
	self sweepToCoallesceFreeSpaceForPigCompactFrom: lowestForwarder.
	self assert: manager numberOfForwarders = 0