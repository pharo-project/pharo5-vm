generating machine code
generateInstructions
	"See Cogit>>computeMaximumSizes, generateInstructionsAt: & outputInstructionsAt:.
	 This is a pure Smalltalk (non-Slang) version of that trio of methods."
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
	instructions := ByteArray new: address.
	address := 0.
	opcodes do:
		[:abstractInstruction| | machineCodeBytes |
		self assert: abstractInstruction address = address.
		machineCodeBytes := self memoryAsBytes: abstractInstruction machineCode object.
		1 to: abstractInstruction machineCodeSize do:
			[:j|
			instructions at: address + 1 put: (machineCodeBytes at: j).
			address := address + 1]].
	^instructions