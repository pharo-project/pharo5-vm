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
		int annotationSize = sizeof(InstructionAnnotation) * ((numAbstractOpcodes + 3) / 4); \
		int allocSize = opcodeSize + fixupSize + annotationSize; \
		if (allocSize > MaxStackAllocSize) failBlock; \
		abstractOpcodes = alloca(allocSize); \
		bzero(abstractOpcodes, opcodeSize + fixupSize); \
		fixups = (void *)((char *)abstractOpcodes + opcodeSize); \
		annotations = (void *)((char *)fixups + fixupSize); \
		opcodeIndex = labelCounter = annotationIndex = 0; \
} while (0)'>
	| opcodeSize fixupSize annotationSize allocSize |
	opcodeSize := (self sizeof: CogAbstractInstruction) * numberOfAbstractOpcodes.
	fixupSize := (self sizeof: CogBytecodeFixup) * numberOfAbstractOpcodes.
	annotationSize := (self sizeof: CogInstructionAnnotation) * ((numberOfAbstractOpcodes + 3) / 4).
	allocSize := opcodeSize + fixupSize + annotationSize.
	allocSize > MaxStackAllocSize ifTrue: [^failBlock value].
	numAbstractOpcodes := numberOfAbstractOpcodes.
	abstractOpcodes := CArrayAccessor on:
						((1 to: numAbstractOpcodes) collect:
							[:ign| processor abstractInstructionCompilerClass for: self]).
	fixups := CArrayAccessor on:
						((1 to: numAbstractOpcodes) collect:
							[:ign| self bytecodeFixupClass new]).
	annotations := CArrayAccessor on:
						((1 to: numAbstractOpcodes + 3 // 4) collect:
							[:ign| CogInstructionAnnotation new]).
	opcodeIndex := labelCounter := annotationIndex := 0