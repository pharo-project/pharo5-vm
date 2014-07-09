generate machine code - concretize
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch."
	"If the quick constant is in fact a shiftable 8bit, generate the apropriate MOV, otherwise do what is necessary for a whole word."
	<inline: true>
	self 
		rotateable8bitImmediate: (operands at: 0) 
		ifTrue: [:rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self mov: reg imm: immediate ror: rot).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeMoveCwR].
	