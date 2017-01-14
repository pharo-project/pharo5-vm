as yet unclassified
initializeContextIndices
	"Class MethodContext"
	| contextFixedSizePlusHeader |
	SenderIndex := 0.
	InstructionPointerIndex := 1.
	StackPointerIndex := 2.
	MethodIndex := 3.
	ClosureIndex := 4. "N.B. Called receiverMap in the image."
	ReceiverIndex := 5.
	TempFrameStart := 6.  "Note this is in two places!"

	"Class BlockContext"
	CallerIndex := 0.
	BlockArgumentCountIndex := 3.
	InitialIPIndex := 4.
	HomeIndex := 5.

	"Class BlockClosure"
	ClosureOuterContextIndex := 0.
	ClosureStartPCIndex := 1.
	ClosureNumArgsIndex := 2.
	ClosureFirstCopiedValueIndex := 3.

	CtxtTempFrameStart := 6.  "Copy of TempFrameStart in Interp"
	contextFixedSizePlusHeader := CtxtTempFrameStart + 1.
	SmallContextSize := contextFixedSizePlusHeader + 16 * self wordSize.  "16 indexable fields"
	"Large contexts have 56 indexable fileds.  Max with single header word."
	"However note that in 64 bits, for now, large contexts have 3-word headers"
	LargeContextSize := contextFixedSizePlusHeader + 56 * self wordSize