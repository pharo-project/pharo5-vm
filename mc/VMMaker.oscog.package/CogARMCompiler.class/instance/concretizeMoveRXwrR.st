generate machine code - concretize
concretizeMoveRXwrR
	"Will get inlined into concretizeAt: switch."
	"Write the word in R(src) into memory at address (base+4*index)"
	<inline: true>
	| index base src |
	src := self concreteRegister: (operands at: 0).
	index := self concreteRegister: (operands at: 1).
	base := self concreteRegister: (operands at: 2).
	"str		src, [base, +index, LSL #2]"
	"cond 011 1100 0 base srcR 00010 00 0 inde"
	self machineCodeAt: 0 put: (self type: 3 op: 16rC set: 0 rn: base rd: src shifterOperand: (16r100 bitOr: index)).
	^machineCodeSize := 4