generate machine code
concretizeLiteral
	self assert: (dependent notNil and: [dependent opcode = Literal and: [dependent address = address]]).
	self machineCodeAt: 0 put: (operands at: 0)