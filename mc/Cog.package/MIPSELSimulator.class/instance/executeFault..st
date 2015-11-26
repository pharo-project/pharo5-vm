memory
executeFault: address
	| jumpInstruction type |
	self assert: inDelaySlot not.
	jumpInstruction := MIPSInstruction new value: (self fetchInstruction: jumpingPC).
	jumpInstruction opcode = J ifTrue: [type := #jump].
	jumpInstruction opcode = JAL ifTrue: [type := #call].
	jumpInstruction opcode = SPECIAL ifTrue: 
		[jumpInstruction function = JR ifTrue:
			[jumpInstruction rs = RA
				ifTrue: [type := #return]
				ifFalse: [type := #jump]].
		jumpInstruction function = JALR ifTrue:
			[type := #call]].
	self assert: type ~~ nil.

	^(ProcessorSimulationTrap
			pc: nil
			nextpc: nil
			address: address
			type: type
			accessor: nil)
		signal