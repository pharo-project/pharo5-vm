tests
testReturnTrap
	"return above-range."
	
	"self new testReturnTrap"
	| memory |
	memory := self memory.
	self processor reset.

	"assemble a nasty number in r10"
	memory unsignedLongAt: 5 put: (CogARMCompiler new mov: 10 imm: 16r1E ror: 8)  bigEndian: false. 
	memory unsignedLongAt: 9 put: (CogARMCompiler new orr: 10 imm: 0 ror: 0) bigEndian: false.
	memory unsignedLongAt: 13 put: (CogARMCompiler new orr: 10 imm: 0 ror: 0) bigEndian: false. 
	memory unsignedLongAt: 17 put: (CogARMCompiler new orr: 10 imm: 1 ror: 0) bigEndian: false. 
	"push this on the stack"
	memory unsignedLongAt: 21 put: (CogARMCompiler new pushR: 10) bigEndian: false.
	"pop the stack into pc to emulate a return via stack as generated in  various trampoline code"	
	memory unsignedLongAt: 25 put: (CogARMCompiler new popR: 15) bigEndian: false.

	
	"processor disassembleFrom: 0 to: 60 in: memory on: Transcript cr"
	self processor
			pc: 4;
			sp: (memory size - 4); "Room for return address"
			singleStepIn: memory readExecuteOnlyBelow: memory size /2 .
			"We have to step several times, because the first step only changes the pc, but does not fetch anything from the address it points to."
	self should: [self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2.
				self processor singleStepIn: memory readExecuteOnlyBelow: memory size /2]
		raise: ProcessorSimulationTrap
		withExceptionDo:
			[:pst|
			self assert: self processor pc = 16r18.
			self assert: pst pc = 16r18.
			self assert: pst nextpc = 16r1C.
			self assert: pst address = 16r1E000000.
			self assert: pst type = #return].