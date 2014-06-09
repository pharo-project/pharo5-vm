generate machine code - concretize
concretizeSubCqR
	"Will get inlined into concretizeAt: switch."
	"Try whether the quick constant is a small negative number. If it is, optimize."
	<inline: true>
	self rotateable8bitImmediate: (operands at: 0)
		ifTrue: [ :rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self subs: reg rn: reg imm: immediate ror: rot<<1).
			^machineCodeSize := 4]
		ifFalse: [
			"before building a full load of a big cinstant, see if we can do an add of the constant negated"
			self rotateable8bitImmediate: (operands at: 0) negated
				ifTrue: [ :rot :immediate | | reg |
					reg := self concreteRegister: (operands at: 1).
					self machineCodeAt: 0 put: (self adds: reg rn: reg imm: immediate ror: rot<<1).
					^machineCodeSize := 4]
				ifFalse: [^self concretizeDataOperationCwR: 2]]