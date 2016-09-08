smalltalk calling convention
genSaveStackPointers
	"Save the frame and stack pointer registers to the framePointer
	 and stackPointer variables.  Used to save the machine code frame
	 for use by the run-time when calling into the CoInterpreter run-time."
	cogit MoveR: FPReg Aw: cogit framePointerAddress.
	cogit MoveR: SPReg Aw: cogit stackPointerAddress.
	^0