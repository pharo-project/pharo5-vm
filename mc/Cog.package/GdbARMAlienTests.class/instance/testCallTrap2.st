tests
testCallTrap2
	"Call a function that is out-of-range.  Ensure the call is trapped
	This version calls well outside the memory array."
	"self new testCallTrap2"
	| memory |
	memory := self memory.
	memory unsignedLongAt: 5 put: (CogARMCompiler new bl: 16rFF00) bigEndian: false.
	"Can't do this diassemble until after the #asByteArray - "
	"processor disassembleFrom: 0 to:16 in: memory on: Transcript cr"
	self processor
			pc: 4;
			sp: (memory size - 4); "Room for return address"
			singleStepIn: memory.
			"We have to step twice, because the first step only changes the pc, but does not fetch anything from the address it points to."
	self should: [self processor singleStepIn: memory]
		raise: ProcessorSimulationTrap
		withExceptionDo:
			[:pst|
			self assert: self processor pc = 16r4.
			self assert: self processor lr = 8.
			self assert: pst pc = 4.
			self assert: pst nextpc = 8.
			self assert: pst address  = 16rFF0C.
			self assert: pst type = #call].