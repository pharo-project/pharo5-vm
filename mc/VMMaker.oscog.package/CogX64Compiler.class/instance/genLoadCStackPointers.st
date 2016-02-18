smalltalk calling convention
genLoadCStackPointers
	"Load the frame and stack pointer registers with those of the C stack,
	 effecting a switch to the C stack.  Used when machine code calls into
	 the CoInterpreter run-time (e.g. to invoke interpreter primitives)."
	cogit MoveAw: cogit cStackPointerAddress R: SPReg.
	cogit MoveAw: cogit cFramePointerAddress R: FPReg.
	^0