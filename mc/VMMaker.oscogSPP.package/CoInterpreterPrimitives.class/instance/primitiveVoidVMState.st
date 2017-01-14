system control primitives
primitiveVoidVMState
	"Void all internal VM state in the stack and machine code zones

	 Override to jump to the interpreter because the machine code zone is now void."
	| activeContext |
	self push: instructionPointer.
	activeContext := self voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
	self siglong: reenterInterpreter jmp: ReturnToInterpreter
	"NOTREACHED"