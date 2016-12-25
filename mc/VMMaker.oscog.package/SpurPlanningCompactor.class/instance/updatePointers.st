compaction
updatePointers
	"Sweep the heap, updating all objects to their eventual locations.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded."
	| onePass |
	coInterpreter mapInterpreterOops.
	self updatePointersInManagerHeapEntities.
	self updatePointersInSurvivingObjects.
	self updatePointersInInitialImmobileObjects.
	onePass := self updatePointersInMobileObjects.
	onePass ifFalse:
		[self updatePointersInObjectsOverflowingSavedFirstFieldsSpace]