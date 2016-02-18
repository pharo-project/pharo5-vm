error handling
handleFailingBranch: instr to: address at: pc
	(self instructionIsBL: instr) ifTrue:
		[self assert: address = (pc + 8 + (self extractOffsetFromBL: instr)) signedIntToLong.
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (pc + 8 + (self extractOffsetFromBL: instr)) signedIntToLong
				type: #call)
			signal].
	(self instructionIsBLX: instr) ifTrue:
		[self assert: address = (self perform: (self registerStateGetters at: (instr bitAnd: 15) + 1)).
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (self perform: (self registerStateGetters at: (instr bitAnd: 15) + 1))
				type: #call)
			signal].
	(self instructionIsBX: instr) ifTrue:
		[self assert: address = (self perform: (self registerStateGetters at: (instr bitAnd: 15) + 1)).
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (self perform: (self registerStateGetters at: (instr bitAnd: 15) + 1))
				type: #jump)
			signal].
	(self instructionIsB: instr) ifTrue:
		[self assert: address = (pc + 8 + (self extractOffsetFromBL: instr)) signedIntToLong.
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (pc + 8 + (self extractOffsetFromBL: instr)) signedIntToLong
				type: #jump)
			signal].
	(self instructionIsReturnViaLR: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: self lr
				type: #return)
			signal].
	^self reportPrimitiveFailure