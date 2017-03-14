simulation only
byteSizeForSimulator: aVMClass
	"Answer an approximation of the byte size of an AbstractInstruction struct.
	 This is for estimating the alloca in allocateOpcodes:bytecodes:ifFail:
	 self allSubclasses collect: [:ea| {ea. ea byteSizeForSimulator: ea basicNew}]"
	| ptrsize |
	ptrsize := self == CogAbstractInstruction ifTrue: [BytesPerWord] ifFalse: [self wordSize].
	^CogCompilerClass instSize
		- 4 "cogit, objectMemory, bcpc, machineCode"
		- 4 + 1
	"opcode machineCodeSize maxSize annotation are all bytes -> 1 long" * ptrsize
	+ CogCompilerClass basicNew machineCodeBytes
		roundTo: ptrsize