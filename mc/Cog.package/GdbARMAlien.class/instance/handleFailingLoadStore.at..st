error handling
handleFailingLoadStore: instr at: pc
	"See e.g. ARM DDI0406A pp. A8-120, 124, 128, 132, 152, 156, etc. etc"
	| baseReg destReg srcReg offset |

	"find the register used as the base of the address and the register to load into or store from"
	baseReg := self registerStateGetters at: (instr >> 16 bitAnd: 15)+ 1.
	srcReg :=  self registerStateGetters at: (instr >> 12 bitAnd: 15)+ 1.
	destReg := self registerStateSetters at: (instr >> 12 bitAnd: 15) + 1.

	"work out the relevant offset, whether an immediate or register value"
	offset := self extractOffsetFromLoadStore: instr.
	
	(self instructionIsLDR: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #read
				accessor: destReg)
			signal].
	(self instructionIsLDRB: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #read
				accessor: destReg)
			signal].
	(self instructionIsLDRH: instr) ifTrue:
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
	(self instructionIsSTRB: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #write
				accessor: srcReg)
			signal].
	(self instructionIsSTRH: instr) ifTrue:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4 
				address: (self perform: baseReg) + offset
				type: #write
				accessor: srcReg)
			signal].

	self error: 'handleFailingLoadStore:at: invoked for non-load/store?'