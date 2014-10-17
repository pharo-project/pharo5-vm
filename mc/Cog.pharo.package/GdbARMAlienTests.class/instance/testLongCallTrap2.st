tests
testLongCallTrap2
	"Long-Call a function that is way outside range."
	
	"self new testLongCallTrap2"
	| memory |
	memory := self memory.
	self processor reset.

	memory unsignedLongAt: 5 put: (CogARMCompiler new mov: 10 imm: 16rFF ror: 8)  bigEndian: false. 
	memory unsignedLongAt: 9 put: (CogARMCompiler new orr: 10 imm: 0 ror: 0) bigEndian: false.
	memory unsignedLongAt: 13 put: (CogARMCompiler new orr: 10 imm: 4 ror: 24) bigEndian: false. 
	memory unsignedLongAt: 17 put: (CogARMCompiler new orr: 10 imm: 0 ror: 0) bigEndian: false. 

	memory unsignedLongAt: 21 put: (CogARMCompiler new blx: 10) bigEndian: false.

	memory unsignedLongAt: 25 put: (CogARMCompiler new mov:5imm: 99 ror:0 ) bigEndian: false.
	memory unsignedLongAt: 41 put: (CogARMCompiler new mov: 4 imm: 42 ror: 0) bigEndian: false.
	memory unsignedLongAt: 45 put: (CogARMCompiler new bx: 14) bigEndian: false.
	
	"processor disassembleFrom: 0 to: 60 in: memory on: Transcript cr"
	self processor
			pc: 4;
			sp: (memory size - 4); "Room for return address"
			singleStepIn: memory.
			"We have to step several times, because the first step only changes the pc, but does not fetch anything from the address it points to."
	self should: [self processor singleStepIn: memory.
				self processor singleStepIn: memory.
				self processor singleStepIn: memory.
				self processor singleStepIn: memory.
				self processor singleStepIn: memory.
				self processor singleStepIn: memory.
				self processor singleStepIn: memory]
		raise: ProcessorSimulationTrap
		withExceptionDo:
			[:pst|
			self assert: self processor pc = 16r14.
			self assert: self processor lr = 16r18.
			self assert: pst pc = 16r14.
			self assert: pst nextpc = 16r18.
			self assert: pst address = 16rFF000400.
			self assert: pst type = #call].