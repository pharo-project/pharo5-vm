encoding
jtype: opcode target: target
	self assert: (opcode between: 0 and: 63).
	self assert: (opcode between: 0 and: 16r7FFFFFF).
	^(opcode << 26) bitOr: target