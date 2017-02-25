compaction
copyAndUnmark: firstPass
	"Sweep the heap, unmarking all objects and moving mobile objects to their correct positions,
	 restoring their savedFirstFields."
	<inline: #never>
	| finalPass |
	self logPhase: 'copying and unmarking...'.
	firstPass ifTrue:
		[self unmarkInitialImmobileObjects].
	finalPass := self copyAndUnmarkMobileObjects.
	(self thereAreObjectsToMove
	 and: [finalPass not
	 and: [biasForGC]]) ifTrue: "only ever one pass if biasForGC is true."
		[self unmarkObjectsFromFirstFreeObject]