tests
testReturnTrapWithThumbBug
	"return above-range with a bad address that ends in 1 - which triggers an ARM sim bug"
	
	"self new testReturnTrapWithThumbBug"
	| memory |
	memory := self memory.
	self processor reset.

	"pop the stack into pc to emulate a return via stack as generated in  various trampoline code"	
	memory unsignedLongAt: 1 put: (CogARMCompiler new mov: 15 rn: 14) bigEndian: false.

	
	"processor disassembleFrom: 0 to: 60 in: memory on: Transcript cr"
	self processor
			pc: 0;
			sp: (memory size - 4); "Room for return address"
			pushWord:16r1E000001 in: memory;
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