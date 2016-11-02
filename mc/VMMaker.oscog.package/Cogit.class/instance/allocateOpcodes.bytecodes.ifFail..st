initialization
allocateOpcodes: numberOfAbstractOpcodes bytecodes: numberOfBytecodes ifFail: failBlock
	"Allocate the various arrays needed to compile abstract instructions, failing if the size
	 needed is considered too high.  Notionally we only need as many fixups as there are
	 bytecodes.  But we reuse fixups to record pc-dependent instructions in
	 generateInstructionsAt: and so need at least as many as there are abstract opcodes.

	 This *must* be inlined since the arrays are alloca'ed (stack allocated)
	 so that they are freed when compilation is done.

	 N.B. We do one single alloca to save embarrassing C optimizers that
	 generate incorrect code as both gcc and the intel compiler do on x86."
	<inline: true>
	| opcodeBytes fixupBytes allocBytes |
	numAbstractOpcodes := numberOfAbstractOpcodes.
	opcodeBytes := (self sizeof: CogAbstractInstruction) * numAbstractOpcodes.
	fixupBytes := (self sizeof: CogBytecodeFixup) * numAbstractOpcodes.
	allocBytes := opcodeBytes + fixupBytes.
	allocBytes > MaxStackAllocSize ifTrue: [^failBlock value].
	self
		cCode:
			[abstractOpcodes := self alloca: allocBytes.
			 self b: abstractOpcodes zero: allocBytes.
			 fixups := (abstractOpcodes asUnsignedInteger + opcodeBytes) asVoidPointer]
		inSmalltalk:
			[abstractOpcodes := CArrayAccessor on:
									 ((1 to: numAbstractOpcodes) collect: [:ign| CogCompilerClass for: self]).
			 fixups := CArrayAccessor on:
						((1 to: numAbstractOpcodes) collect: [:ign| self bytecodeFixupClass for: self])].
	self zeroOpcodeIndexForNewOpcodes.
	labelCounter := 0