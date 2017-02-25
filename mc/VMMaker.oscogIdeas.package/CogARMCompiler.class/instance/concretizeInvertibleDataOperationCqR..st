generate machine code - concretize
concretizeInvertibleDataOperationCqR: armOpcode
	"Will get inlined into concretizeAt: switch."
	"Xor == 1, And == 0, Or == 12, Bic == 14"
	<inline: true>
	| val rn |
	val := operands at: 0.
	rn := operands at: 1.
	self deny: opcode = CmpOpcode.

	self rotateable8bitBitwiseImmediate: val 
		ifTrue:
			[:rot :immediate : invert|
			self machineCodeAt: 0
				put: (self
						type: 1
						op: (invert ifTrue: [self inverseOpcodeFor: armOpcode] ifFalse: [armOpcode])
						set: 1
						rn: rn
						rd: rn
						shifterOperand: (rot >> 1"in this usage we have to halve the rot value" << 8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: "let's try to see if the constant can be made from a simple shift of 0xFFFFFFFF"
			[val > 0 ifTrue:
				[| hb |
				hb := val highBit.
				1 << hb = (val +1) ifTrue: "MVN temp,  #0, making 0xffffffff"
					[self machineCodeAt: 0 put: (self mvn: ConcreteIPReg imm: 0 ror: 0).
					 "Then armOpcode reg, temp reg, lsr #(32-hb)"
					 self machineCodeAt: 4 put: (self dataOpType: armOpcode rd: rn  rn: rn rm: ConcreteIPReg lsr: 32 - hb).
					^machineCodeSize := 8]].
			 ^self concretizeDataOperationCqR: armOpcode].
	^0 "to keep Slang happy"