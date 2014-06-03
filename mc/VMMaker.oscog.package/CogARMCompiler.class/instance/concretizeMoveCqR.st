generate machine code - concretize
concretizeMoveCqR
	"Will get inlined into concretizeAt: switch."
	"If the quick constant is in fact a shiftable 8bit, generate the apropriate MOV, otherwise do what is necessary for a whole word."
	<inline: true>
	self 
		rotateable8bitImmediate: (operands at: 0) 
		ifTrue: [:rot :immediate | | reg |
			reg := self concreteRegister: (operands at: 1).
			self machineCodeAt: 0 put: (self type: 1 op: 16rD set: 0 rn: 0 rd: reg shifterOperand: (rot << 8 bitOr: immediate)).
			^machineCodeSize := 4]
		ifFalse: [^self concretizeMoveCwR].
	