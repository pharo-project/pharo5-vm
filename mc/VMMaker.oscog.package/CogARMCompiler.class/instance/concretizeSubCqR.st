generate machine code - concretize
concretizeSubCqR
	"Will get inlined into concretizeAt: switch."
	"Try whether the quick constant is a small negative number. If it is, optimize."
	<inline: true>
	self rotateable8bitImmediate: (operands at: 0)
		ifTrue: [ :rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self type: 1 op: 2 set: 1 rn: reg rd: reg shifterOperand: (rot << 8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: [
			self rotateable8bitImmediate: (operands at: 0) negated
				ifTrue: [ :r :i | 
						opcode := AddCqR.
						operands at: 0 put: (operands at: 0) negated.
						^self concretizeDataOperationCqR: 4]
				ifFalse: [^self concretizeDataOperationCwR: 2]]