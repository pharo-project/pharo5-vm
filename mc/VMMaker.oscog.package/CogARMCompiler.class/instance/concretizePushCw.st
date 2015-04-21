generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word  instrOffset |
	word := (operands at: 0) - (address + 8).
	
	self rotateable8bitImmediate: word
		ifTrue: [ :rot :immediate |
			self machineCodeAt: 0 put: (self add: ConcreteIPReg rn: PC imm: immediate ror: rot).
			instrOffset := 4]
		ifFalse: [self rotateable8bitImmediate: word negated
				ifTrue: [ :rot :immediate |
					self machineCodeAt: 0 put: (self sub: ConcreteIPReg rn: PC imm: immediate ror: rot).
					instrOffset := 4]
				ifFalse: [instrOffset := self at: 0 moveCw: word intoR: ConcreteIPReg]].
		self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset +4