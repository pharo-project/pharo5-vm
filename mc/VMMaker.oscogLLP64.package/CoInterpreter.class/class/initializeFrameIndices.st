initialization
initializeFrameIndices
	"Format of a stack frame.  Word-sized indices relative to the frame pointer.
	 Terminology
		Frames are either single (have no context) or married (have a context).
		Contexts are either single (exist on the heap), married (have a context) or widowed (had a frame that has exited).
	 Stacks grow down:

			receiver for method activations/closure for block activations
			arg0
			...
			argN
			caller's saved ip/this stackPage (for a base frame)
	fp->	saved fp
			method
			context (initialized to nil)
			frame flags (interpreter only)
			saved method ip (initialized to 0; interpreter only)
			receiver
			first temp
			...
	sp->	Nth temp

	In an interpreter frame
		frame flags holds
			the backward jump count (see ifBackwardsCheckForEvents)
			the number of arguments (since argument temporaries are above the frame)
			the flag for a block activation
			and the flag indicating if the context field is valid (whether the frame is married).
		saved method ip holds the saved method ip when the callee frame is a machine code frame.
		This is because the saved method ip is actually the ceReturnToInterpreterTrampoline address.
	In a machine code frame
		the flag indicating if the context is valid is the least significant bit of the method pointer
		the flag for a block activation is the next most significant bit of the method pointer

	Interpreter frames are distinguished from method frames by the method field which will
	be a pointer into the heap for an interpreter frame and a pointer into the method zone for
	a machine code frame.

	The first frame in a stack page is the baseFrame and is marked as such by a saved fp being its stackPage,
	in which case the first word on the stack is the caller context (possibly hybrid) beneath the base frame."

	| fxCallerSavedIP fxSavedFP fxMethod fxIFrameFlags fxThisContext fxIFReceiver fxMFReceiver fxIFSavedIP |
	fxCallerSavedIP := 1.
	fxSavedFP := 0.
	fxMethod := -1.
	fxThisContext := -2.
	fxIFrameFlags := -3.	"Can find numArgs, needed for fast temp access. args are above fxCallerSavedIP.
							 Can find ``is block'' bit
							 Can find ``has context'' bit"
	fxIFSavedIP := -4.
	fxIFReceiver := -5.
	fxMFReceiver := -3.

	"For debugging undefine values that differ in the StackInterpreter."
	FrameSlots := #undefined.
	IFrameSlots := fxCallerSavedIP - fxIFReceiver + 1.
	MFrameSlots := fxCallerSavedIP - fxMFReceiver + 1.

	FoxCallerSavedIP := fxCallerSavedIP * BytesPerWord.
	"In Cog a base frame's caller context is stored on the first word of the stack page."
	FoxCallerContext := #undefined.
	FoxSavedFP := fxSavedFP * BytesPerWord.
	FoxMethod := fxMethod * BytesPerWord.
	FoxThisContext := fxThisContext * BytesPerWord.
	FoxFrameFlags := #undefined.
	FoxIFrameFlags := fxIFrameFlags * BytesPerWord.
	FoxIFSavedIP := fxIFSavedIP * BytesPerWord.
	FoxReceiver := #undefined.
	FoxIFReceiver := fxIFReceiver * BytesPerWord.
	FoxMFReceiver := fxMFReceiver * BytesPerWord.

	"N.B.  There is room for one more flag given the current 8 byte alignment of methods (which
	 is at least needed to distinguish the checked and uncecked entry points by their alignment."
	MFMethodFlagHasContextFlag := 1.
	MFMethodFlagIsBlockFlag := 2.
	MFMethodFlagFrameIsMarkedFlag := 4. "for pathTo:using:followWeak:"
	MFMethodFlagsMask := MFMethodFlagHasContextFlag + MFMethodFlagIsBlockFlag + MFMethodFlagFrameIsMarkedFlag.
	MFMethodMask := (MFMethodFlagsMask + 1) negated