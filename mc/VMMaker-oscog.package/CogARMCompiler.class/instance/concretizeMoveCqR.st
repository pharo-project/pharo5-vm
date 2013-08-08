generate machine code - concretize
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch."
	"If the quick constant is in fact a shiftable 8bit, generate the apropriate MOV, otherwise do what is necessary for a whole word."
	<inline: true>
	self 
		rotateable8bitImmediate: (operands at: 0) 
		ifTrue: [:rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self t: 1 o: 16rD s: 0).
			machineCode at: 0 put: immediate.
			machineCode at: 1 put: (reg << 4 bitOr: rot).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeMoveCwR].
	