compile abstract instructions
compileAbstractInstructionsFrom: start through: end
	"Loop over bytecodes, dispatching to the generator for each bytecode, handling fixups in due course."
	| nextOpcodeIndex descriptor fixup result nExts |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #fixup type: #'BytecodeFixup *'>
	bytecodePC := start.
	nExts := 0.
	[byte0 := (objectMemory fetchByte: bytecodePC ofObject: methodObj)  + bytecodeSetOffset.
	 descriptor := self generatorAt: byte0.
	 self loadSubsequentBytesForDescriptor: descriptor at: bytecodePC.
	 nextOpcodeIndex := opcodeIndex.
	 result := self perform: descriptor generator.
	 descriptor isExtension ifFalse: "extended bytecodes must consume their extensions"
		[self assert: (extA = 0 and: [extB = 0])].
	 fixup := self fixupAt: bytecodePC - initialPC.
	 fixup targetInstruction ~= 0 ifTrue:
		["There is a fixup for this bytecode.  It must point to the first generated
		   instruction for this bytecode.  If there isn't one we need to add a label."
		 opcodeIndex = nextOpcodeIndex ifTrue:
			[self Label].
		 fixup targetInstruction: (self abstractInstructionAt: nextOpcodeIndex)].
	 bytecodePC := self nextBytecodePCFor: descriptor at: bytecodePC exts: nExts in: methodObj.
	 result = 0 and: [bytecodePC <= end]]
		whileTrue:
			[nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	self checkEnoughOpcodes.
	^result