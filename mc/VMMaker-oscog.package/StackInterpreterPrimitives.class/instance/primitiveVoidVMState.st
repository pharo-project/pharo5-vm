system control primitives
primitiveVoidVMState
	"Void all internal VM state in the stack and machine code zones"
	| activeContext |
	self push: instructionPointer.
	activeContext := self voidVMStateForSnapshot.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext