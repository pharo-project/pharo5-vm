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
			caller's method ip/base frame's sender context
	fp->	saved fp
			method
			frame flags
			context (uninitialized)
			receiver
			first temp
			...
	sp->	Nth temp

	frame flags holds the number of arguments (since argument temporaries are above the frame)
	the flag for a block activation
	and the flag indicating if the context field is valid (whether the frame is married).

	The first frame in a stack page is the baseFrame and is marked as such by a null saved fp,
	in which case the saved method ip is actually the context (possibly hybrid) beneath the base frame"

	| fxCallerSavedIP fxSavedFP fxMethod fxFrameFlags fxThisContext fxReceiver |
	fxCallerSavedIP := 1.
	fxSavedFP := 0.
	fxMethod := -1.
	fxFrameFlags := -2.	"Can find numArgs, needed for fast temp access. args are above fxCallerSavedIP.
						 Can find ``is block'' bit
						 Can find ``has context'' bit"
	fxThisContext := -3.
	fxReceiver := -4.

	FrameSlots := fxCallerSavedIP - fxReceiver + 1.

	FoxCallerSavedIP := fxCallerSavedIP * BytesPerWord.
	"In base frames the caller saved ip field holds the caller context."
	FoxCallerContext := FoxCallerSavedIP.
	FoxSavedFP := fxSavedFP * BytesPerWord.
	FoxMethod := fxMethod * BytesPerWord.
	FoxFrameFlags := fxFrameFlags * BytesPerWord.
	FoxThisContext := fxThisContext * BytesPerWord.
	FoxReceiver := fxReceiver * BytesPerWord.

	"Mark the CoInterpreter-specific offsets as #undefined to
	 avoid including them accidentally in StackInterpreter code."
	IFrameSlots := #undefined.
	MFrameSlots := #undefined.
	FoxIFrameFlags := #undefined.
	FoxIFSavedIP := #undefined.
	FoxIFReceiver := #undefined.
	FoxMFReceiver := #undefined