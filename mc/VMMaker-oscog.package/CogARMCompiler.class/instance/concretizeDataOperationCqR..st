generate machine code - concretize
concretizeDataOperationCqR: opcode
	"Will get inlined into concretizeAt: switch."
	"4 == Add, 2 == Sub, Xor == 1, And == 0, Or == 12"
	<inline: true>
	self 
		rotateable8bitImmediate: (operands at: 0) 
		ifTrue: [:rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: ((self t: 1 o: opcode s: 1) bitOr: reg << 16).
			machineCode at: 0 put: immediate.
			machineCode at: 1 put: (reg << 4 bitOr: rot).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeDataOperationCwR: opcode].
	