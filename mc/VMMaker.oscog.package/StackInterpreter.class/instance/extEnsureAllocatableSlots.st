miscellaneous bytecodes
extEnsureAllocatableSlots
	"SistaV1		*	236		11101100	iiiiiiii		Ensure Allocatable Slots (+ Extend A * 256)"
	| slots ok |
	slots := (extA bitShift: 8) + self fetchByte.
	self fetchNextBytecode.
	extA := 0.
	ok := objectMemory checkForAvailableSlots: slots.
	ok ifFalse:
		[self externalizeIPandSP.
		 self checkForEventsMayContextSwitch: true.
		 self browserPluginReturnIfNeeded.
		 self internalizeIPandSP]