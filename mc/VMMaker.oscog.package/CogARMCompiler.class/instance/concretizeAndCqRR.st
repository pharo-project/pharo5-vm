generate machine code - concretize
concretizeAndCqRR
	"Will get inlined into concretizeAt: switch."
	"AND is very important since it's used to mask all sorts of flags in the jit. We take special care to try to find fast ways to make the masks"
	<inline: true>
	| val srcReg dstReg |
	val := operands at: 0.
	srcReg := self concreteRegister: (operands at: 1).
	dstReg := self concreteRegister: (operands at: 2).
	self rotateable8bitImmediate: val
		ifTrue:
			[ :rot :immediate |
			self machineCodeAt: 0 put: (self ands: dstReg rn: srcReg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse:
			["see if the constant bit-inverted makes a quick value and if so BIC it instead
			If the value is -ve, we 2s complement it instead"
			|invVal|
			invVal := val < 0
						ifTrue:[-1 - val]
						ifFalse:[val bitInvert32].
			self rotateable8bitImmediate: invVal
				ifTrue:
					[ :rot :immediate |
					self machineCodeAt: 0 put: (self bics: dstReg rn: srcReg imm: immediate ror: rot).
					^machineCodeSize := 4]
				ifFalse: "let's try to see if the constant can be made from a simple shift of 0xFFFFFFFF"
					[| hb |
					hb := (operands at: 0) highBit.
					1 << hb = (val +1)
						ifTrue: "MVN temp reg, 0, making 0xffffffff"
							[self machineCodeAt: 0 put:(self mvn: ConcreteIPReg imm: 0 ror: 0).
							"Then AND reg, temp reg, lsr #(32-hb)"
							 self machineCodeAt: 4 put: (self dataOpType: AndOpcode rd: dstReg rn: srcReg rm: ConcreteIPReg lsr: 32 - hb).
							^machineCodeSize := 8]
						ifFalse:
							[^self concretizeDataOperationCwR: AndOpcode]]]