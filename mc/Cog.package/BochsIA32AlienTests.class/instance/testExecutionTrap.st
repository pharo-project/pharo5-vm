tests
testExecutionTrap
	"Execute a run of nops.  test executing beyond the executable limit is trapped."
	"self new testExecutionTrap"
	| memory |
	 "The address is out of range of memory every which way (whether relative or absolute and whether big-endian or little."
	memory := ByteArray new: 4096 * 2 withAll: self processor nopOpcode.
	self processor
			eip: 0;
			esp: (memory size - 4). "Room for return address"
	self should: [self processor runInMemory: memory minimumAddress: 0 readOnlyBelow: memory size / 2]
		raise: Error
		withExceptionDo:
			[:err|
			self assert: self processor pc = (memory size / 2).
			self assert: ('*EIP*> CS.limit*' match: err messageText)].
	self processor eip: 0.
	self should: [[self processor singleStepIn: memory minimumAddress: 0 readOnlyBelow: memory size / 2] repeat]
		raise: Error
		withExceptionDo:
			[:err|
			self assert: self processor pc = (memory size / 2).
			self assert: ('*EIP*> CS.limit*' match: err messageText)]