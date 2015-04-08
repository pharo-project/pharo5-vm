generate machine code - concretize
concretizePushCq
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word instrOffset|
	word := operands at: 0.
	self 
		rotateable8bitImmediate: word 
		ifTrue: [:rot :immediate |
			self machineCodeAt: 0 put: (self mov: ConcreteIPReg imm: immediate ror: rot).
			instrOffset := 4]
		ifFalse:[|invVal|
			word <0
				ifTrue:[invVal := -1 - word]
				ifFalse:[invVal := word bitInvert32].
			self rotateable8bitImmediate: invVal
				ifTrue: [ :rot :immediate |
					self machineCodeAt: 0 put: (self mvn: ConcreteIPReg imm: immediate ror: rot).
					^machineCodeSize := 4]
				ifFalse: [instrOffset := self at: 0 moveCw: word intoR: ConcreteIPReg]].
	self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4