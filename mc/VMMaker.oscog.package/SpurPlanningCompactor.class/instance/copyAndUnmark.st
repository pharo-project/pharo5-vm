compaction
copyAndUnmark
	"Sweep the heap, unmarking all objects and moving mobile objects to their correct positions,
	 restoring their savedFirstFields."
	| onePass |
	self logPhase: 'copying and unmarking...'.
	self unmarkInitialImmobileObjects.
	"If savedFirstFieldsSpace is empty there is nothing to move, and no second pass."
	savedFirstFieldsSpace top < savedFirstFieldsSpace start ifTrue:
		[self assert: firstMobileObject >= manager endOfMemory.
		 ^self].
	onePass := self copyAndUnmarkMobileObjectsWithTop: savedFirstFieldsSpace start - manager bytesPerOop.
	onePass ifFalse:
		[self unmarkObjectsOverflowingSavedFirstFieldsSpace]