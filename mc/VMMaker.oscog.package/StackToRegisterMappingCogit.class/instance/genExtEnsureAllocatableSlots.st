bytecode generators
genExtEnsureAllocatableSlots
	"SistaV1	*	236	11101100	iiiiiiii	Ensure Allocatable Slots (+ Extend A * 256)"
	self ssFlushTo: simStackPtr.
	^super genExtEnsureAllocatableSlots