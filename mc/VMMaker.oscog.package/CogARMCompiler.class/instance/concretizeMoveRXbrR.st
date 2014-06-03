generate machine code - concretize
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	"Write the word in R(src) into memory at address (base+1*index)"
	<inline: true>
	| index base src |
	src := self concreteRegister: (operands at: 0).
	index := self concreteRegister: (operands at: 1).
	base := self concreteRegister: (operands at: 2).
	"str		src, [base, +index, LSL #0]"
	"cond 011 1100 0 base srcR 00000 00 0 inde"
	self machineCodeAt: 0 put: (self type: 3 op: 16rC set: 0 rn: base rd: src shifterOperand: index).
	^machineCodeSize := 4