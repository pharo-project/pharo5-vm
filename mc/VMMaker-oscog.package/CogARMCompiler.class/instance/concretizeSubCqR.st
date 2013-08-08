generate machine code - concretize
concretizeSubCqR
	"Will get inlined into concretizeAt: switch."
	"Try whether the quick constant is a small negative number. If it is, optimize."
	<inline: true>
	self rotateable8bitImmediate: (operands at: 0)
		ifTrue: [ :rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: ((self t: 1 o: 2 s: 1) bitOr: reg << 16).
			machineCode at: 0 put: immediate.
			machineCode at: 1 put: (reg << 4 bitOr: rot).
			^machineCodeSize := 4]
		ifFalse: [
			self rotateable8bitImmediate: (operands at: 0) negated
				ifTrue: [ :r :i | 
						opcode := AddCqR.
						operands at: 0 put: (operands at: 0) negated.
						^self concretizeDataOperationCqR: 4]
				ifFalse: [^self concretizeDataOperationCwR: 2]]