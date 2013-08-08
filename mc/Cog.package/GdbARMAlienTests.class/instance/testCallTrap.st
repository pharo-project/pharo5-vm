tests
testCallTrap
	"Call a function that is out-of-range.  Ensure the call is trapped."
	"self new testCallTrap"
	| memory |
	memory := Bitmap new: 256 withAll: self processor nopOpcode.
	memory longAt: 5 put: (self processor branchAndLinkOpcodeWithOffset: 1020) bigEndian: false.
	memory := memory asByteArray.
	self processor
			pc: 4;
			sp: (memory size - 4); "Room for return address"
			singleStepIn: memory.
			"We have to step twice, because the first step only changes the pc, but does not fetch anything from the address it points to."
	self should: [self processor singleStepIn: memory]
		raise: ProcessorSimulationTrap
		withExceptionDo:
			[:pst|
			self assert: self processor pc = 1024.
			self assert: self processor lr = 8.
			self assert: pst pc = 4.
			self assert: pst nextpc = 8.
			self assert: pst address = 1024.
			self assert: pst type = #call].