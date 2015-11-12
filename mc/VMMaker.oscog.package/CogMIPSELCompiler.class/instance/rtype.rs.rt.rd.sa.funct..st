encoding
rtype: opcode rs: rs rt: rt rd: rd sa: sa funct: funct
	self assert: (opcode between: 0 and: 63).
	self assert: (rs between: 0 and: 31).
	self assert: (rt between: 0 and: 31).
	self assert: (rd between: 0 and: 31).
	self assert: (sa between: 0 and: 15).
	self assert: (funct between: 0 and: 63).
	^(((((opcode << 26) bitOr: (rs << 21)) bitOr: (rt << 16)) bitOr: (rd << 11)) bitOr: (sa << 6)) bitOr: funct