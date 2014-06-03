object memory support
postBecomeAction: theBecomeEffectsFlags
	"Clear the gcMode var and let the Cogit do its post GC checks."
	super postBecomeAction: theBecomeEffectsFlags.

	cogit cogitPostGCAction: gcMode.

	lastCoggableInterpretedBlockMethod := lastUncoggableInterpretedBlockMethod := nil.

	gcMode := 0