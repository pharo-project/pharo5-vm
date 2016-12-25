compaction
copyAndUnmark
	"Sweep the heap, unmarking all objects and moving mobile objects to their correct positions,
	 restoring their savedFirstFields."
	| onePass |
	self unmarkInitialImmobileObjects.
	onePass := self copyAndUnmarkMobileObjects.
	onePass ifFalse:
		[self unmarkObjectsOverflowingSavedFirstFieldsSpace]