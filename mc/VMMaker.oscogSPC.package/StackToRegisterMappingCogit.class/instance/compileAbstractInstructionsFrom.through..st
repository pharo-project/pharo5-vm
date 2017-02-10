compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course."
	| nextOpcodeIndex descriptor nExts fixup result |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #fixup type: #'BytecodeFixup *'>
	self traceSimStack.
	bytecodePC := start.
	nExts := result := 0.
	descriptor := nil.
	deadCode := false.
	[self maybeHaltIfDebugPC.
	 fixup := self fixupAt: bytecodePC.
	 self mergeWithFixupIfRequired: fixup.
	 self assertCorrectSimStackPtr.
	 descriptor := self loadBytesAndGetDescriptor.
	 nextOpcodeIndex := opcodeIndex.
	 result := deadCode
				ifTrue: [self mapDeadDescriptorIfNeeded: descriptor]
				ifFalse: [self perform: descriptor generator].
	 self assertExtsAreConsumed: descriptor.
	 self traceDescriptor: descriptor; traceSimStack.
	 self patchFixupTargetIfNeeded: fixup nextOpcodeIndex: nextOpcodeIndex.
	 self maybeDumpLiterals: descriptor.
	 bytecodePC := self nextBytecodePCFor: descriptor exts: nExts.
	 result = 0 and: [bytecodePC <= end]] whileTrue:
		[nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	self checkEnoughOpcodes.
	^result