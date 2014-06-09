compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course."
	| nextOpcodeIndex descriptor nExts fixup result |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #fixup type: #'BytecodeFixup *'>
	self traceSimStack.
	bytecodePC := start.
	nExts := 0.
	descriptor := nil.
	deadCode := false.
	[self cCode: '' inSmalltalk:
		[(debugBytecodePointers includes: bytecodePC) ifTrue: [self halt]].
	fixup := self fixupAt: bytecodePC - initialPC.
	fixup targetInstruction asUnsignedInteger > 0
		ifTrue:
			[deadCode := false.
	 		 fixup targetInstruction asUnsignedInteger >= 2 ifTrue:
				[self merge: fixup
					afterContinuation: (descriptor notNil
										and: [descriptor isUnconditionalBranch
											or: [descriptor isReturn]]) not]]
		ifFalse: "If there's no fixup following a return there's no jump to that code and it is dead."
			[(descriptor notNil and: [descriptor isReturn]) ifTrue:
				[deadCode := true]].
	 self cCode: '' inSmalltalk:
		[deadCode ifFalse:
			[self assert: simStackPtr + (needsFrame ifTrue: [0] ifFalse: [1])
						= (self debugStackPointerFor: bytecodePC)]].
	 byte0 := (objectMemory fetchByte: bytecodePC ofObject: methodObj) + bytecodeSetOffset.
	 descriptor := self generatorAt: byte0.
	 self loadSubsequentBytesForDescriptor: descriptor at: bytecodePC.
	 nextOpcodeIndex := opcodeIndex.
	 result := deadCode
				ifTrue: "insert nops for dead code that is mapped so that bc to mc mapping is not many to one"
					[(descriptor isMapped
					  or: [inBlock and: [descriptor isMappedInBlock]]) ifTrue:
						[self annotateBytecode: self Nop].
						0]
				ifFalse:
					[self perform: descriptor generator].
	 descriptor isExtension ifFalse: "extended bytecodes must consume their extensions"
		[self assert: (extA = 0 and: [extB = 0])].
	 self traceDescriptor: descriptor; traceSimStack.
	 (fixup targetInstruction asUnsignedInteger between: 1 and: 2) ifTrue:
		["There is a fixup for this bytecode.  It must point to the first generated
		   instruction for this bytecode.  If there isn't one we need to add a label."
		 opcodeIndex = nextOpcodeIndex ifTrue:
			[self Label].
		 fixup targetInstruction: (self abstractInstructionAt: nextOpcodeIndex)].
	 bytecodePC := self nextBytecodePCFor: descriptor at: bytecodePC exts: nExts in: methodObj.
	 result = 0 and: [bytecodePC <= end]] whileTrue:
		[nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	self checkEnoughOpcodes.
	^result