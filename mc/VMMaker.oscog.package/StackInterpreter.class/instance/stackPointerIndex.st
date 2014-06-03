internal interpreter access
stackPointerIndex
	"Return the 1-based value of the stack pointer for the current frame.
	 This is what the value of the stackp slot would be in a context object."
	^self stackPointerIndexForFrame: framePointer WithSP: stackPointer