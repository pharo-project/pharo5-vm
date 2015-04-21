generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| operand instrOffset distance |
	operand := operands at: 0.
	instrOffset := 0.
	"First try and encode as a pc-relative reference..."
	(cogit addressIsInCodeZone: operand) ifTrue:
		[distance := operand  - (address + 8).
		 self rotateable8bitImmediate: distance
		 	ifTrue: [ :rot :immediate |
		 		self machineCodeAt: 0 put: (self add: ConcreteIPReg rn: PC imm: immediate ror: rot).
		 		instrOffset := 4]
		 	ifFalse:
		 		[self rotateable8bitImmediate: distance negated
		 			ifTrue: [ :rot :immediate |
		 				self machineCodeAt: 0 put: (self sub: ConcreteIPReg rn: PC imm: immediate ror: rot).
		 				instrOffset := 4]
				ifFalse: [instrOffset := 0]]].
	"If this fails, use the conventional and painfully long 4 instruction sequence."
	instrOffset = 0 ifTrue:
		[instrOffset := self at: 0 moveCw: operand intoR: ConcreteIPReg].
	self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4