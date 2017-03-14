simulation only
byteSizeForSimulator: aVMClass
	"Answer an approximation of the byte size of an AbstractInstruction struct.
	 This is for estimating the alloca in allocateOpcodes:bytecodes:ifFail:
	 self withAllSubclasses collect: [:ea| { ea byteSizeForSimulator: ea basicNew. ea typedef}]"
	^(LowcodeVM ifTrue: [self instSize - 1] ifFalse: [self instSize - 2]) * (aVMClass sizeof: #'void *')