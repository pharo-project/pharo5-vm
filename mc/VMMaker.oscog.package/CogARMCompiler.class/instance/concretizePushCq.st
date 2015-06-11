generate machine code - concretize
concretizePushCq
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word instrOffset |
	word := operands at: 0.
	self 
		rotateable8bitBitwiseImmediate: word 
		ifTrue:
			[:rot :immediate :invert|
			self machineCodeAt: 0
				put: (invert
						ifTrue: [self mvn: ConcreteIPReg imm: immediate ror: rot]
						ifFalse: [self mov: ConcreteIPReg imm: immediate ror: rot]).
			instrOffset := 4]
		ifFalse:
			[instrOffset := self moveCw: word intoR: ConcreteIPReg].
	self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4