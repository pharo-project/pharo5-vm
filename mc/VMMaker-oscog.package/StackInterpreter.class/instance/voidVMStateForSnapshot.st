frame access
voidVMStateForSnapshot
	"Make sure that all VM state that affects the heap contents is voided so that the heap is ready
	 to be snapshotted. Answer the activeContext object that should be stored in the snapshot."
	| activeContext |
	<inline: false>
	activeContext := self divorceAllFrames.
	self bereaveAllMarriedContexts.
	^activeContext