error handling
handleFailingLoadStore: instr at: pc
	| baseReg destReg srcReg offset |
	baseReg := self registerStateGetters at: (instr >> 16 bitAnd: 15)+ 1.
	destReg := self registerStateSetters at: (instr >> 12 bitAnd: 15) + 1.
	srcReg := self registerStateGetters at: (instr >> 12 bitAnd: 15) + 1.
	"See e.g. A5.2.2/A5-20 ARM ARM v6"
	offset := (instr >> 21 bitAnd: 2r1111001) = 2r0101000
				ifTrue:
					[(instr >> 23 anyMask: 1) "U bit"
						ifTrue: [instr bitAnd: 16rFFF]
						ifFalse: [(instr bitAnd: 16rFFF) negated]]
				ifFalse:
					[0].
	(self instructionIsLDR: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #read
				accessor: destReg)
			signal].
	(self instructionIsSTR: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #write
				accessor: srcReg)
			signal].
	"Lars handled byte read/write failures.  i don't think we need to"
	"(self instructionIsLDRB: instr) ifTrue:
		[??].
	(self instructionIsSTRB: instr) ifTrue:
		[??]."
	self error: 'handleFailingLoadStore:at: invoked for non-load/store?'