generate machine code - concretize
concretizeAndCqRR
	"Will get inlined into concretizeAt: switch."
	"AND is very important since it's used to mask all sorts of flags in the jit. We take special care to try to find compact ways to make the masks"
	<inline: true>
	| val srcReg dstReg |
	val := operands at: 0.
	srcReg := operands at: 1.
	dstReg := operands at: 2.
	self rotateable8bitBitwiseImmediate: val
		ifTrue:
			[:rot :immediate :invert|
			self machineCodeAt: 0 put: (invert
											ifTrue: [self bics: dstReg rn: srcReg imm: immediate ror: rot]
											ifFalse: [self ands: dstReg rn: srcReg imm: immediate ror: rot]).
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
					[^self concretizeDataOperationCwR: AndOpcode]].
	^0 "to keep Slang happy"