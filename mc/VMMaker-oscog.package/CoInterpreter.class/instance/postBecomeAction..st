object memory support
postBecomeAction: becomeEffectsFlags
	"Clear the gcMode var and let the Cogit do its post GC checks."
	super postBecomeAction: becomeEffectsFlags.

	cogit cogitPostGCAction: gcMode.

	lastCoggableInterpretedBlockMethod := lastUncoggableInterpretedBlockMethod := nil.

	gcMode := 0