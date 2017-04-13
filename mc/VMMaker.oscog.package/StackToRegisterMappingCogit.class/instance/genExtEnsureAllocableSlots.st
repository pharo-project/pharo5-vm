bytecode generators
genExtEnsureAllocableSlots
	"SistaV1	*	236	11101100	iiiiiiii	Ensure Allocable Slots (+ Extend A * 256)"
	self ssFlushTo: simStackPtr.
	^super genExtEnsureAllocableSlots