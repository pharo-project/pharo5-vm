frame access
voidVMStateForSnapshot
	"Make sure that all VM state that affects the heap contents is voided so that the heap is ready
	 to be snapshotted. Answer the activeContext object that should be stored in the snapshot."
	<inline: false>
	| activeContext |
	instructionPointer := 0. "in case of code compactions."
	activeContext := self divorceAllFrames.
	self ensureAllContextsHaveBytecodePCsOrAreBereaved.
	cogit voidCogCompiledCode.
	^activeContext