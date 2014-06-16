gc - global
eliminateAndFreeForwardersForPigCompact
	"As the final phase of global garbage collect, sweep the heap to follow
	 forwarders, then free forwarders, coalescing with free space as we go."
	<inline: false>
	| lowestForwarder |
	<var: #lowestForwarder type: #usqInt>
	self assert: (self isForwarded: nilObj) not.
	self assert: (self isForwarded: falseObj) not.
	self assert: (self isForwarded: trueObj) not.
	self assert: (self isForwarded: self freeListsObj) not.
	self assert: (self isForwarded: hiddenRootsObj) not.
	self assert: (self isForwarded: classTableFirstPage) not.
	self followSpecialObjectsOop.
	self followForwardedObjStacks.
	coInterpreter mapInterpreterOops.
	scavenger followRememberedForwardersAndForgetFreeObjectsForPigCompact.
	self unmarkSurvivingObjectsForPigCompact.
	lowestForwarder := self sweepToFollowForwardersForPigCompact.
	self sweepToCoallesceFreeSpaceForPigCompactFrom: lowestForwarder.
	self assert: self numberOfForwarders = 0