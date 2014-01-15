object memory support
postBecomeAction
	"Clear the gcMode var and let the Cogit do its post GC checks."
	cogit cogitPostGCAction: gcMode.

	lastCoggableInterpretedBlockMethod := lastUncoggableInterpretedBlockMethod := nil.

	gcMode := 0