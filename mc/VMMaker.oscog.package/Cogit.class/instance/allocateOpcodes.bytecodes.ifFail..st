initialization
allocateOpcodes: numberOfAbstractOpcodes bytecodes: numberOfBytecodes ifFail: failBlock
	"Allocate the various arrays needed to compile abstract instructions.
	 This needs to be a macro since the arrays are alloca'ed (stack allocated)
	 to ensure their being freed when compilation is done.
	 Notionally we only need as many fixups as there are bytecodes.  But we
	 reuse fixups to record pc-dependent instructions in generateInstructionsAt:
	 and so need at least as many as there are abstract opcodes.

	 N.B. We do one single alloca to save embarrassing C optimizers that
	 generate incorrect code as both gcc and the intel compiler do on x86."
	<cmacro: '(numberOfAbstractOpcodes,numberOfBytecodes,failBlock) do { \
		int opcodeSize = sizeof(AbstractInstruction) * (numAbstractOpcodes = (numberOfAbstractOpcodes)); \
		int fixupSize = sizeof(BytecodeFixup) * numAbstractOpcodes; \
		int allocSize = opcodeSize + fixupSize; \
		if (allocSize > MaxStackAllocSize) failBlock; \
		abstractOpcodes = alloca(allocSize); \
		bzero(abstractOpcodes, opcodeSize + fixupSize); \
		fixups = (void *)((char *)abstractOpcodes + opcodeSize); \
		opcodeIndex = labelCounter = 0; \
} while (0)'>
	| opcodeSize fixupSize allocSize |
	opcodeSize := (self sizeof: CogAbstractInstruction) * numberOfAbstractOpcodes.
	fixupSize := (self sizeof: CogBytecodeFixup) * numberOfAbstractOpcodes.
	allocSize := opcodeSize + fixupSize.
	allocSize > MaxStackAllocSize ifTrue: [^failBlock value].
	numAbstractOpcodes := numberOfAbstractOpcodes.
	abstractOpcodes := CArrayAccessor on:
						((1 to: numAbstractOpcodes) collect:
							[:ign| CogCompilerClass for: self]).
	fixups := CArrayAccessor on:
						((1 to: numAbstractOpcodes) collect:
							[:ign| self bytecodeFixupClass new]).
	opcodeIndex := labelCounter := 0