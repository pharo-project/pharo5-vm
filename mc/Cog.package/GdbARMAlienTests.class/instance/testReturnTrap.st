tests
testReturnTrap
	"return above-range with a bad address"
	
	"self new testReturnTrap"
	| memory badAddress|
	badAddress := 16r1E000000. 
	memory := self memory.
	self processor reset.

	"pop the stack into pc to emulate a return via stack as generated in  various trampoline code"	
	memory unsignedLongAt: 1 put: (CogARMCompiler new mov: 15 rn: 14) bigEndian: false.

	
	"processor disassembleFrom: 0 to: 60 in: memory on: Transcript cr"
	self processor
			pc: 0;
			sp: (memory size - 4); "Room for return address"
			lr: badAddress;
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
			self assert: self processor pc = 0.
			self assert: pst pc = 0.
			self assert: pst nextpc = 4.
			self assert: pst address = badAddress.
			self assert: pst type = #return].