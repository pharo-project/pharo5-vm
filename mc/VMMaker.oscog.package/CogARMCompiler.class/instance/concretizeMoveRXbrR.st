generate machine code - concretize
concretizeMoveRXbrR
	"Will get inlined into concretizeAt: switch."
	"Write the word in R(src) into memory at address (base+1*index)"
	<inline: true>
	| index base src |
	src := self concreteRegister: (operands at: 0).
	index := self concreteRegister: (operands at: 1).
	base := self concreteRegister: (operands at: 2).
	"str	b	src, [base, +index, LSL #0]"
	"cond 011 1100 0 base srcR 00000 00 0 index"
	self machineCodeAt: 0 put: (self strb: src rn: base rm: index).
	^machineCodeSize := 4