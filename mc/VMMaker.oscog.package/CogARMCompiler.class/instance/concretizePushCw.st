generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word instrOffset |
	word := operands at: 0.	
	(self inCurrentCompilation: word)
		ifTrue:
			[instrOffset := self loadCwInto: ConcreteIPReg]
		ifFalse:
			[self 
				rotateable8bitBitwiseImmediate: word 
				ifTrue:
					[:rot :immediate :invert|
					self machineCodeAt: 0
						put: (invert
								ifTrue: [self mvn: ConcreteIPReg imm: immediate ror: rot]
								ifFalse: [self mov: ConcreteIPReg imm: immediate ror: rot]).
					instrOffset := 4]
				ifFalse:
					[instrOffset := self loadCwInto: ConcreteIPReg]].
	self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4