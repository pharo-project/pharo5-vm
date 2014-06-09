generate machine code - concretize
concretizeAndCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	self rotateable8bitImmediate: (operands at: 0)
		ifTrue: [ :rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self ands: reg rn: reg imm: immediate ror: rot<<1).
			^machineCodeSize := 4]
		ifFalse: [
			"see if the constant bit-inverted makes a quick value and if so BIC it instead
			If the value is -ve, we 2s complement it instead"
			|val|
			val := operands at: 0.
			val <0 ifTrue:[val := -1 - val] ifFalse:[val := val bitInvert32].
			self rotateable8bitImmediate: val
				ifTrue: [ :rot :immediate | |reg|
					reg := self concreteRegister: (operands at: 1).
					self machineCodeAt: 0 put: (self bics: reg rn: reg imm: immediate ror: rot<<1).
					^machineCodeSize := 4]
				ifFalse: [^self concretizeDataOperationCwR: 0]]