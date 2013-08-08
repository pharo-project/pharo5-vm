tests
testExecutionTrap
	"Execute a run of nops.  test executing beyond the executable limit is trapped."
	"self new testExecutionTrap"
	| memory |
	 "The address is out of range of memory every which way (whether relative or absolute and whether big-endian or little."
	memory := (Bitmap new: 1024 * 2 withAll: self processor nopOpcode) asByteArray.
	self processor
			pc: 0;
			sp: (memory size - 4). "Room for return address"
	self should: [self processor runInMemory: memory minimumAddress: 0 readOnlyBelow: memory size / 2]
		raise: Error
		withExceptionDo:
			[:err|
			self assert: self processor pc = (memory size / 2).
			self assert: ('Error 0: Illegal Instruction fetch address (0x1000).' match: err messageText)].
	self processor pc: 0.
	self should: [[self processor singleStepIn: memory minimumAddress: 0 readOnlyBelow: memory size / 2] repeat]
		raise: Error
		withExceptionDo:
			[:err|
			self assert: self processor pc = (memory size / 2).
			self assert: ('Error 0: Illegal Instruction fetch address (0x1000).' match: err messageText)]