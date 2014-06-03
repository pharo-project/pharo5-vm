frame access
voidVMStateForSnapshotFlushingExternalPrimitivesIf: flushExtPrims
	"Make sure that all VM state that affects the heap contents is voided so that the heap is
	 ready to be snapshotted.  If flushExtPrims is true, flush references to external
	 primitives in methods.  Answer the activeContext that should be stored in the snapshot."
	| activeContext |
	<inline: false>
	activeContext := self divorceAllFrames.
	self bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: flushExtPrims.
	^activeContext