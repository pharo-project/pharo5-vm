simulation only
byteSizeForSimulator: aVMClass
	"Answer an approximation of the byte size of an AbstractInstruction struct.
	 This is for estimating the alloca in allocateOpcodes:bytecodes:ifFail:"
	| concreteClass ptrsize |
	concreteClass := aVMClass processor abstractInstructionCompilerClass.
	ptrsize := aVMClass sizeof: #'void *'.
	^concreteClass instSize - 4 "cogit, objectMemory et al" * ptrsize
	+ concreteClass basicNew machineCodeBytes
		roundTo: ptrsize