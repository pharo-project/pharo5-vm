object memory support
postBecomeAction: theBecomeEffectsFlags
	"Clear the gcMode var and let the Cogit do its post GC checks."
	super postBecomeAction: theBecomeEffectsFlags.

	(objectMemory hasSpurMemoryManagerAPI
	 and: [theBecomeEffectsFlags anyMask: OldBecameNewFlag]) ifTrue:
		[cogit addAllToYoungReferrers].
	cogit cogitPostGCAction: gcMode.

	lastCoggableInterpretedBlockMethod := lastUncoggableInterpretedBlockMethod := nil.

	gcMode := 0