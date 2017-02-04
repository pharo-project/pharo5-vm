compaction
copyAndUnmark: firstPass
	"Sweep the heap, unmarking all objects and moving mobile objects to their correct positions,
	 restoring their savedFirstFields."
	<inline: #never>
	| finalPass |
	self logPhase: 'copying and unmarking...'.
	firstPass ifTrue:
		[self unmarkInitialImmobileObjects].
	"If savedFirstFieldsSpace is empty there is nothing to move, and no second pass."
	savedFirstFieldsSpace top < savedFirstFieldsSpace start ifTrue:
		[self assert: ((self oop: firstMobileObject isGreaterThanOrEqualTo: manager endOfMemory)
					or: [lastMobileObject < firstMobileObject]).
		 ^self].
	finalPass := self copyAndUnmarkMobileObjects.
	(finalPass not and: [biasForGC]) ifTrue: "only ever one pass if biasForGC is true."
		[self unmarkObjectsAfterLastMobileObject]