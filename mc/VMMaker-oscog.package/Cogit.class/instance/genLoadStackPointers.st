trampoline support
genLoadStackPointers
	"Switch back to the Smalltalk stack. Assign SPReg first
	 because typically it is used immediately afterwards."
	self MoveAw: coInterpreter stackPointerAddress R: SPReg.
	self MoveAw: coInterpreter framePointerAddress R: FPReg.
	^0