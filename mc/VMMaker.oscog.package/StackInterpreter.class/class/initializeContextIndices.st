initialization
initializeContextIndices
	"Class MethodContext"
	SenderIndex := 0.
	InstructionPointerIndex := 1.
	StackPointerIndex := 2.
	MethodIndex := 3.
	ClosureIndex := 4. "N.B. Called receiverMap in old images, closureOrNil in newer images."
	ReceiverIndex := 5.
	CtxtTempFrameStart := 6.

	SmallContextSlots := CtxtTempFrameStart + 16.  "16 indexable fields"
	"Large contexts have 56 indexable fields.  Max with single header word of ObjectMemory [but not SpurMemoryManager ;-)]."
	LargeContextSlots := CtxtTempFrameStart + 56.
	
	"Including the header size in these sizes is problematic for multiple memory managers,
	 so we don't use them.  Set to #bogus for error checking."
	SmallContextSize := #bogus.
	LargeContextSize := #bogus.

	"Class BlockClosure"
	ClosureOuterContextIndex := 0.
	ClosureStartPCIndex := 1.
	ClosureNumArgsIndex := 2.
	ClosureFirstCopiedValueIndex := 3.
	
	"Class FullBlockClosure, outercontext and numArgs index are shared with the BlockClosure class."	
	FullClosureCompiledBlockIndex := 1.
	FullClosureReceiverIndex := 3.
	FullClosureFirstCopiedValueIndex := 4.