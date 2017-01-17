simulation only
byteSizeForSimulator: aVMClass
	"Answer an approximation of the byte size of an AbstractInstruction struct.
	 This is for estimating the alloca in allocateOpcodes:bytecodes:ifFail:"
	| ptrsize |
	ptrsize := aVMClass sizeof: #'void *'.
	^CogCompilerClass instSize - 4 "cogit, objectMemory et al" * ptrsize
	+ CogCompilerClass basicNew machineCodeBytes
		roundTo: ptrsize