compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course."
	| nextOpcodeIndex descriptor fixup result nExts |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #fixup type: #'BytecodeFixup *'>
	bytecodePC := start.
	nExts := result := 0.
	descriptor := nil.
	[self maybeHaltIfDebugPC.
	 descriptor := self loadBytesAndGetDescriptor.
	 nextOpcodeIndex := opcodeIndex.
	 result := self perform: descriptor generator.
	 self assertExtsAreConsumed: descriptor.
	 fixup := self fixupAt: bytecodePC.
	 self patchFixupTargetIfNeeded: fixup nextOpcodeIndex: nextOpcodeIndex.
	 self maybeDumpLiterals: descriptor.
	 bytecodePC := self nextBytecodePCFor: descriptor exts: nExts.
	 result = 0 and: [bytecodePC <= end]]
		whileTrue:
			[nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	self checkEnoughOpcodes.
	^result