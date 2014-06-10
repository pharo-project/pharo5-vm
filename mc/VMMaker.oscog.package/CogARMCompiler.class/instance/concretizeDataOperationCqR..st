generate machine code - concretize
concretizeDataOperationCqR: opcode
	"Will get inlined into concretizeAt: switch."
	"4 == Add, 2 == Sub, Xor == 1, And == 0, Or == 12, Bic == 14"
	<inline: true>
	self 
		rotateable8bitImmediate: (operands at: 0) 
		ifTrue: [:rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self type: 1 op: opcode set: 1 rn: reg rd: reg shifterOperand: (rot << 8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeDataOperationCwR: opcode].
	