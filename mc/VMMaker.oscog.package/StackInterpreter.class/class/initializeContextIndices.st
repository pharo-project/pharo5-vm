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
	 so we don't use them, except LargeContextSize for asserts.  Set small to #bogus for error checking."
	SmallContextSize := #bogus.
	LargeContextSize := LargeContextSlots * BytesPerOop + BaseHeaderSize.

	"Class BlockClosure"
	ClosureOuterContextIndex := 0.
	ClosureStartPCIndex := 1.
	ClosureNumArgsIndex := 2.
	ClosureFirstCopiedValueIndex := 3.
	ClosureCopiedValuesIndex := 3