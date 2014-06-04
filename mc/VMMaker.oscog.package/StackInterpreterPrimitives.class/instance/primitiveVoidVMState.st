system control primitives
primitiveVoidVMState
	"Void all internal VM state in the stack and machine code zones"
	| activeContext |
	self push: instructionPointer.
	activeContext := self voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
	self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext