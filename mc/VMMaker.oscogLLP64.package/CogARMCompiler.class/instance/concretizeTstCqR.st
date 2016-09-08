generate machine code - concretize
concretizeTstCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	self rotateable8bitImmediate: (operands at: 0)
		ifTrue: [ :rot :immediate | | reg |
			reg := operands at: 1.
			self machineCodeAt: 0 put: (self tst: reg rn: reg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeDataOperationCwR: TstOpcode].
	^0 "to keep Slang happy"