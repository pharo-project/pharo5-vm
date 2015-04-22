generate machine code - concretize
concretizeAndCqR
	"Will get inlined into concretizeAt: switch."
	"AND is very important since it's used to mask all sorts of flags in the jit. We take special care to try to find fast ways to make the masks"
	<inline: true>
	|val|
	val := operands at: 0.
	self rotateable8bitImmediate: val
		ifTrue: [ :rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self ands: reg rn: reg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse: [
			"see if the constant bit-inverted makes a quick value and if so BIC it instead
			If the value is -ve, we 2s complement it instead"
			|invVal|
			val <0
				ifTrue:[invVal := -1 - val]
				ifFalse:[invVal := val bitInvert32].
			self rotateable8bitImmediate: invVal
				ifTrue: [ :rot :immediate | |reg|
					reg := self concreteRegister: (operands at: 1).
					self machineCodeAt: 0 put: (self bics: reg rn: reg imm: immediate ror: rot).
					^machineCodeSize := 4]
				ifFalse: ["let's try to see if the constant can be made from a simple shift of 0xFFFFFFFF"
					|hb reg|
					reg := self concreteRegister: (operands at: 1).
					hb := (operands at: 0) highBit.
					1 << hb = (val +1)
						ifTrue: [ "MVN temp reg, 0, making 0xffffffff"
							self machineCodeAt: 0 put:(self mvn: ConcreteIPReg imm: 0 ror: 0).
							"Then AND reg, temp reg, lsr #(32-hb)"
							 self machineCodeAt: 4 put:(self dataOpType: AndOpcode rd: reg rn: reg rm: ConcreteIPReg lsr: (32-hb )).
							^machineCodeSize :=8]
						ifFalse: [^self concretizeDataOperationCwR: AndOpcode]]].
	^0 "to keep Slang happy"