generating machine code
generateInstructions
	"See Cogit>>computeMaximumSizes, generateInstructionsAt: & outputInstructionsAt:.
	 This is a pure Smalltalk (non-Slang) version of that trio of methods.
	 The wrinkle here is that in teh simulator a CogARMInstruction's machien code is a simple Array of integers, not a ByteArray of four byte quads."
	| address pcDependentInstructions instructions |
	address := 0.
	pcDependentInstructions := OrderedCollection new.
	opcodes do:
		[:abstractInstruction|
		abstractInstruction
			address: address;
			maxSize: abstractInstruction computeMaximumSize.
		address := address + abstractInstruction maxSize].
	address := 0.
	opcodes do:
		[:abstractInstruction|
		abstractInstruction isPCDependent
			ifTrue:
				[abstractInstruction sizePCDependentInstructionAt: address.
				 pcDependentInstructions addLast: abstractInstruction.
				 address := address + abstractInstruction machineCodeSize]
			ifFalse:
				[address := abstractInstruction concretizeAt: address]].
	pcDependentInstructions do:
		[:abstractInstruction|
		abstractInstruction concretizeAt: abstractInstruction address].
	instructions := Array new: address / 4.
	address := 0.
	opcodes do:
		[:abstractInstruction|
		self assert: abstractInstruction address / 4 = address.
		0 to: abstractInstruction machineCodeSize - 1 by: 4 do:
			[:j|
			instructions at: address + 1 put: (abstractInstruction machineCode at: j / 4).
			address := address + 1]].
	^instructions