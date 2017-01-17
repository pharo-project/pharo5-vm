compile abstract instructions
patchFixupTargetIfNeeded: fixup nextOpcodeIndex: nextOpcodeIndex
	<var: #fixup type: #'BytecodeFixup *'>
	<inline: true>
	 fixup needsFixup ifTrue:
		["There is a fixup for this bytecode.  It must point to the first generated
		   instruction for this bytecode.  If there isn't one we need to add a label."
		 opcodeIndex = nextOpcodeIndex ifTrue: [self Label].
		 fixup targetInstruction: (self abstractInstructionAt: nextOpcodeIndex)].