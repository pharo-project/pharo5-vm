compaction
updatePointers
	"Sweep the heap, updating all objects to their eventual locations.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded."
	<inline: #never>
	| onePass |
	self logPhase: 'updating pointers...'.
	self thereAreObjectsToMove ifFalse:
		[^self].
	self assert: (manager startOfObject: firstFreeObject) = mobileStart.
	coInterpreter mapInterpreterOops.
	manager mapExtraRoots.
	self updatePointersInManagerHeapEntities.
	self updatePointersInSurvivingObjects.
	self updatePointersInInitialImmobileObjects.
	onePass := self updatePointersInMobileObjects.
	onePass ifFalse:
		[self updatePointersInObjectsOverflowingSavedFirstFieldsSpace]