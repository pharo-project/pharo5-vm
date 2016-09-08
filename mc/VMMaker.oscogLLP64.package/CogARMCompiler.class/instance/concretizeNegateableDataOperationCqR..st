generate machine code - concretize
concretizeNegateableDataOperationCqR: armOpcode
	"Will get inlined into concretizeAt: switch."
	"4 == Add, 2 == Sub, 10 = Cmp"
	<inline: true>
	| val rd rn |
	val := operands at: 0.
	rn := operands at: 1.
	"Extra note - if ever a version of this code wants to NOT set the Set flag
	 - Cmp must always have it set or it will pretend to be a SMALALBT and Very Bad Things might happen."
	rd := opcode = CmpOpcode ifTrue: [0] ifFalse: [rn].

	self rotateable8bitSignedImmediate: val 
		ifTrue:
			[:rot :immediate : negate|
			self machineCodeAt: 0
				put: (self
						type: 1
						op: (negate ifTrue: [self inverseOpcodeFor: armOpcode] ifFalse: [armOpcode])
						set: 1
						rn: rn
						rd: rd
						shifterOperand: (rot >> 1"in this usage we have to halve the rot value" << 8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: "let's try to see if the constant can be made from a simple shift of 0xFFFFFFFF"
			[val > 0 ifTrue:
				[| hb |
				hb := val highBit.
				1 << hb = (val +1) ifTrue: "MVN temp,  #0, making 0xffffffff"
					[self machineCodeAt: 0 put:(self mvn: ConcreteIPReg imm: 0 ror: 0).
					 "Then armOpcode reg, temp reg, lsr #(32-hb)"
					 self machineCodeAt: 4 put:(self dataOpType: armOpcode rd: rd  rn: rn rm: ConcreteIPReg lsr: 32 - hb).
					^machineCodeSize := 8]].
			 ^self concretizeDataOperationCwR: armOpcode].
	^0 "to keep Slang happy"